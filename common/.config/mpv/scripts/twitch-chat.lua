-- Standalone Twitch Chat for mpv (no Python required)
-- Place in ~/.config/mpv/scripts/
-- Requires: luasocket, luasec

local o = {
    fetch_aot = 5,
}

local utils = require "mp.utils"
local options = require 'mp.options'
local socket = require "socket"
-- local ssl = require "ssl"

local chat_sid
local is_running
local channelname
local timer
local conn
local comments = {}

options.read_options(o)

-- if not mp.get_script_directory() then
--     mp.msg.error("This script requires to be placed in a script directory")
--     return
-- end

local function random_justinfan()
    math.randomseed(os.time())
    local num = ""
    for i = 1, 3 do
        num = num .. math.random(0, 9)
    end
    return "justinfan" .. num
end

local function send_cmd(conn, cmd, message)
    local command = string.format("%s %s\r\n", cmd, message)
    mp.msg.verbose(">> " .. command)
    conn:send(command)
end

local function parsemsg(s)
    if not s or s == "" then
        return nil
    end
    
    local prefix = ""
    local trailing = {}
    
    if s:sub(1,1) == ":" then
        prefix, s = s:match("^:([^ ]+) (.+)$")
        if not prefix then return nil end
    end
    
    local args
    if s:find(" :") then
        local main, trail = s:match("^(.-)%s+:(.+)$")
        args = {}
        for word in main:gmatch("%S+") do
            table.insert(args, word)
        end
        table.insert(args, trail)
    else
        args = {}
        for word in s:gmatch("%S+") do
            table.insert(args, word)
        end
    end
    
    local command = table.remove(args, 1)
    return prefix, command, args
end

local function wrap_text(text, width)
    local lines = {}
    local line = ""
    for word in text:gmatch("%S+") do
        if #line + #word + 1 > width then
            table.insert(lines, line)
            line = word
        else
            line = line == "" and word or (line .. " " .. word)
        end
    end
    if line ~= "" then
        table.insert(lines, line)
    end
    return table.concat(lines, "\n")
end

local function connect_to_twitch(channel)
    local tcp = socket.tcp()
    tcp:settimeout(5)

    -- tcp:setoption("ip-v6only", false)
    local ok, err = tcp:connect("127.0.0.1", 6667) -- "irc.chat.twitch.tv"
    if not ok then
        mp.msg.error("Failed to connect: " .. tostring(err))
        return nil
    end
    
    -- conn = ssl.wrap(tcp, {mode = "client", protocol = "tlsv1_2"})
    -- ok, err = conn:dohandshake()
    -- if not ok then
    --     mp.msg.error("SSL handshake failed: " .. tostring(err))
    --     return nil
    -- end
    
    -- conn:settimeout(0)
    tcp:settimeout(0)
    conn = tcp
    
    local username = random_justinfan()
    send_cmd(conn, "NICK", username)
    send_cmd(conn, "PASS", "kappa")
    
    if not channel:match("^#") then
        channel = "#" .. channel
    end
    send_cmd(conn, "JOIN", channel)
    
    return conn
end

local function update_subtitle()
    if not conn then return end
    
    local data, err, partial = conn:receive("*l")
    if data or partial then
        local line = data or partial
        mp.msg.info("IRC: " .. line)
        local prefix, command, args = parsemsg(line)
        
        if command == "PING" then
            send_cmd(conn, "PONG", ":" .. (args[1] or ""))
            mp.msg.info("Sent PONG")
        elseif command == "PRIVMSG" and prefix and args and args[2] then
            local user = prefix:match("^([^!]+)")
            mp.msg.info("Chat from " .. user .. ": " .. args[2])
            if user then
                local hash = 0
                for i = 1, #user do
                    hash = (hash * 31 + string.byte(user, i)) % 16777216
                end
                local msg_color = string.format("%06x", hash)
                local msg_text = wrap_text(args[2]:gsub("^%s+", ""):gsub("%s+$", ""), 40)
                local msg_line = string.format('<font color="#%s">%s</font>: %s', msg_color, user, msg_text)
                
                table.insert(comments, msg_line)
                if #comments > 10 then
                    table.remove(comments, 1)
                end
            end
        end
    end
    
    local comments_str = table.concat(comments, "\n")
    local subtitle = string.format("1\n0:0:0,0 --> 999:0:0,0\n%s\n", comments_str)
    
    mp.command_native({"sub-remove", chat_sid})
    mp.command_native({
        name = "sub-add",
        url = "memory://" .. subtitle,
        title = "Twitch Chat"
    })
    chat_sid = mp.get_property_native("sid")
end

local function timer_callback()
    mp.msg.verbose("Timer callback running")
    update_subtitle()
    timer = mp.add_timeout(o.fetch_aot, timer_callback)
end

local function handle_track_change(name, sid)
    if timer and sid then
        timer:resume()
        chat_sid = sid
    elseif timer and not sid then
        if timer then timer:stop() end
    end
end

local function cleanup()
    if timer then
        timer:kill()
        timer = nil
    end
    if conn then
        conn:close()
        conn = nil
    end
    comments = {}
end

local function init()
    cleanup()
    
    channelname = string.match(mp.get_property("path"), "^https://w?w?w?%.?twitch%.tv/([^/]-)$")
    if not channelname then
        return
    end
    
    mp.msg.info("Connecting to Twitch chat for channel: " .. channelname)
    
    conn = connect_to_twitch(channelname)
    if not conn then
        mp.msg.error("Failed to connect to Twitch IRC")
        return
    end
    
    -- Enable subtitles button
    mp.command_native({
        name = "sub-add",
        url = "memory://" .. "1\n0:0:0,0 --> 999:0:0,0\nConnecting to chat...",
        title = "Twitch Chat",
    })
    chat_sid = mp.get_property_native("sid")
    
    timer_callback()
end

mp.register_event("start-file", init)
mp.register_event("end-file", cleanup)
mp.observe_property("current-tracks/sub/id", "native", handle_track_change)
