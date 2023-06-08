----------------------------------------------------------------------
--  Compatibility routines for Lua 4 code.
--  Taken from Lua's compat.lua.
----------------------------------------------------------------------

_INPUT = io.stdin
_OUTPUT = io.stdout

function writeto (name)
  if name == nil then
    local f, err, cod = io.close(_OUTPUT)
    _OUTPUT = io.stdout
    return f, err, cod
  else
    local f, err, cod = io.open(name, "w")
    _OUTPUT = f or _OUTPUT
    return f, err, cod
  end
end

function write (...)
  local f = _OUTPUT
  if type(arg[1]) == 'userdata' then
    f = table.remove(arg, 1)
  end
  return f:write(unpack(arg))
end

function read (...)
  local f = _INPUT
  if type(arg[1]) == 'userdata' then
    f = table.remove(arg, 1)
  end
  return f:read(unpack(arg))
end

function do_ (f, err)
  if not f then _ALERT(err); return end
  local a,b = pcall(f)
  if not a then _ALERT(b); return nil
  else return b or true
  end
end

function dostring(s) return do_(loadstring(s)) end
function dofile(s) return do_(loadfile(s)) end

----------------------------------------------------------------------
--  Load configuration
----------------------------------------------------------------------

function file_exists(filename)
    local f = io.open(filename, "r")
    if f then
	io.close(f)
	return 1
    end
    return nil
end

function dofile_if_fileexists(filename)
    if file_exists(filename) then dofile(filename) end
end

dofile_if_fileexists ("/home/prashant/.local/etc/config.lua")
home_dir = (os.getenv ("HOME") or "/home/"..os.getenv("USER")) or "."
-- elinks_home =  home_dir.."/.config/elinks"
hooks_file = elinks_home.."/hooks.lua" -- for reload()
dofile_if_fileexists (elinks_home.."/config.lua")

----------------------------------------------------------------------
-- hooks
----------------------------------------------------------------------

pre_format_html_hooks = {n=0}
function pre_format_html_hook (url, html)
    local changed = nil

    for i,fn in ipairs(pre_format_html_hooks)
    do
        local new,stop = fn(url,html)

        if new then html=new changed=1 end
    end

    return changed and html
end

goto_url_hooks = {n=0}
function goto_url_hook (url, current_url)
    for i,fn in ipairs(goto_url_hooks)
    do
        local new,stop = fn(url, current_url)

        url = new
    end

    return url
end

follow_url_hooks = {n=0}
function follow_url_hook (url)
    for i,fn in ipairs(follow_url_hooks)
    do
        local new,stop = fn(url)

        url = new

    end

    return url
end

quit_hooks = {n=0}
function quit_hook (url, html)
    for i, fn in ipairs(quit_hooks)
    do
        fn()
    end
end

----------------------------------------------------------------------
--  case-insensitive string.gsub
----------------------------------------------------------------------

-- Please note that this is not completely correct yet.
-- It will not handle pattern classes like %a properly.
-- FIXME: Handle pattern classes.

function gisub (s, pat, repl, n)
    pat = string.gsub (pat, '(%a)',
	        function (v) return '['..string.upper(v)..string.lower(v)..']' end)
    if n then
	return string.gsub (s, pat, repl, n)
    else
	return string.gsub (s, pat, repl)
    end
end

----------------------------------------------------------------------
--  pre_format_html_hook
----------------------------------------------------------------------

-- Plain string.find (no metacharacters).
function sstrfind (s, pattern)
    return string.find (s, pattern, 1, 1)
end

-- Redirect reddit links to old.reddit.com
function reddirect (url, current_url)
  if not ssrtrfind(url, "reddit.com") then return url,nil end
  if sstrfind(url, "old.reddit.com") then return url,nil end

  if sstringfind(url, "www.reddit.com") then
    return string.gsub (url, "www.reddit.com", "old.reddit.com", 1),true
  else
    return string.gsub (url, "reddit.com", "old.reddit.com", 1),true
  end
end
table.insert(goto_url_hooks, reddirect)

-- Redirect twitter links to nitter
function nitter(url, current_url)
  if not sstrfind(url, "twitter.com") then
    -- print("Not twitter")
    return url,nil
  else
    -- print("Is twitter")
    return string.gsub(url, "twitter.com", "nitter.net", 1),true
  end
end
table.insert(goto_url_hooks, nitter)
