local wezterm = require("wezterm")

-- Custom title and icon based on: https://github.com/protiumx/.dotfiles/blob/854d4b159a0a0512dc24cbc840af467ac84085f8/stow/wezterm/.config/wezterm/wezterm.lua#L291-L319
local process_icons = {
    ["bash"] = wezterm.nerdfonts.cod_terminal_bash,
    ["bat"] = wezterm.nerdfonts.md_file_document,
    ["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
    ["btop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
    ["cargo"] = wezterm.nerdfonts.dev_rust,
    ["curl"] = wezterm.nerdfonts.mdi_flattr,
    ["docker"] = wezterm.nerdfonts.linux_docker,
    ["docker-compose"] = wezterm.nerdfonts.linux_docker,
    ["emacs"] = wezterm.nerdfonts.custom_emacs,
    ["ecnw"] = wezterm.nerdfonts.custom_emacs,
    ["eman"] = wezterm.nerdfonts.cod_book,
    ["enw"] = wezterm.nerdfonts.custom_emacs,
    ["fish"] = wezterm.nerdfonts.dev_terminal,
    ["gardenctl"] = wezterm.nerdfonts.fae_plant,
    ["g"] = wezterm.nerdfonts.fae_plant,
    ["gtv"] = wezterm.nerdfonts.fae_plant,
    ["gtc"] = wezterm.nerdfonts.fae_plant,
    ["gtg"] = wezterm.nerdfonts.fae_plant,
    ["gtp"] = wezterm.nerdfonts.fae_plant,
    ["gts"] = wezterm.nerdfonts.fae_plant,
    ["gtt"] = wezterm.nerdfonts.fae_plant,
    ["guc"] = wezterm.nerdfonts.fae_plant,
    ["gug"] = wezterm.nerdfonts.fae_plant,
    ["gg"] = wezterm.nerdfonts.md_graph,
    ["gh"] = wezterm.nerdfonts.dev_github_badge,
    ["git"] = wezterm.nerdfonts.fa_git,
    ["glog"] = wezterm.nerdfonts.md_graph,
    ["go"] = wezterm.nerdfonts.seti_go,
    ["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
    ["hugo"] = wezterm.nerdfonts.seti_go2,
    ["irb"] = wezterm.nerdfonts.cod_ruby,
    ["janet"] = wezterm.nerdfonts.md_face_woman,
    ["kubectl"] = wezterm.nerdfonts.md_kubernetes,
    ["k"] = wezterm.nerdfonts.md_kubernetes,
    ["k9s"] = wezterm.nerdfonts.md_dog,
    ["kuberlr"] = wezterm.nerdfonts.md_kubernetes,
    ["lazydocker"] = wezterm.nerdfonts.linux_docker,
    ["lazygit"] = wezterm.nerdfonts.oct_git_compare,
    ["lua"] = wezterm.nerdfonts.seti_lua,
    ["magit"] = wezterm.nerdfonts.oct_git_compare,
    ["make"] = wezterm.nerdfonts.seti_makefile,
    ["man"] = wezterm.nerdfonts.cod_book,
    ["mdbook"] = wezterm.nerdfonts.dev_markdown,
    ["nix"] = wezterm.nerdfonts.md_nix,
    ["nix-collect-garbage"] = wezterm.nerdfonts.md_nix,
    ["nix-update-mac"] = wezterm.nerdfonts.md_nix,
    ["darwin-rebuild-mac"] = wezterm.nerdfonts.md_nix,
    ["node"] = wezterm.nerdfonts.mdi_hexagon,
    ["nvim"] = wezterm.nerdfonts.custom_vim,
    ["pry"] = wezterm.nerdfonts.cod_ruby,
    ["psql"] = "󱤢",
    ["ruby"] = wezterm.nerdfonts.cod_ruby,
    ["rustc"] = wezterm.nerdfonts.dev_rust,
    ["stern"] = wezterm.nerdfonts.linux_docker,
    ["sudo"] = wezterm.nerdfonts.fa_hashtag,
    ["usql"] = "󱤢",
    ["vim"] = wezterm.nerdfonts.dev_vim,
    ["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
    ["yazi"] = wezterm.nerdfonts.cod_folder,
    ["yy"] = wezterm.nerdfonts.cod_folder,
    ["zig"] = wezterm.nerdfonts.seti_zig,
    ["zsh"] = wezterm.nerdfonts.dev_terminal,
}

-- Return the Tab's current working directory
local function get_cwd_for_color(tab)
    if not tab or not tab.active_pane then
        return " "
    end
    
    local cwd = tab.active_pane.current_working_dir
    if not cwd then
        return " "
    end
    
    return cwd.file_path or " "
end

-- Return the concise name or icon of the running process for display
local function get_process(title)
    if title == nil then
        return ""
    end
    
    local process = title:match("^([^ ]+)")
    if process ~= nil and process and process_icons[process] then
        return " " .. process_icons[process]
    else
        return ""
    end
end

-- Pretty format the tab title
local function parse_cwd(title)
    if not title then return nil end
    local path = title:match("([^ ]+)$")
    if path then
        return path
    end
    return nil
end

-- Determine if a tab has unseen output since last visited
local function has_unseen_output(tab)
    if not tab.is_active then
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then return true end
        end
    end
    return false
end

local function get_tab_title(tab, pane)
    local set_title = tab.tab_title
    local active_title = tab.active_pane.title
    local proc = get_process(active_title)
    if proc == nil then
        proc = ""
    end
    if set_title and #set_title > 0 then return proc .. " " .. set_title end
    local cwd = parse_cwd(active_title)
    return string.format("%s %s", proc, cwd)
end

-- Convert arbitrary strings to a unique hex color value
-- Based on: https://stackoverflow.com/a/3426956/3219667
local function string_to_color(str)
    -- Convert the string to a unique integer
    local hash = 0
    for i = 1, #str do
        hash = string.byte(str, i) + ((hash << 5) - hash)
    end

    -- Convert the integer to a unique color
    local c = string.format("%06X", hash & 0x00FFFFFF)
    return "#" .. (string.rep("0", 6 - #c) .. c):upper()
end

local function select_contrasting_fg_color(hex_color)
    -- Note: this could use `return color:complement_ryb()` instead if you prefer or other builtins!

    local color = wezterm.color.parse(hex_color)
    ---@diagnostic disable-next-line: unused-local
    local lightness, _a, _b, _alpha = color:laba()
    if lightness > 55 then
        return "#000000" -- Black has higher contrast with colors perceived to be "bright"
    end
    return "#FFFFFF" -- White has higher contrast
end

-- On format tab title events, override the default handling to return a custom title
-- Docs: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, pane, config, hover, max_width)
  -- Debug logging
  -- wezterm.log_info(string.format(
  --     "Tab %d - has pane: %s, has active_pane: %s", 
  -- tab.tab_index,
  --     pane ~= nil and "yes" or "no",
  --     tab.active_pane ~= nil and "yes" or "no"
  -- ))
  -- if tab.active_pane then
  --     wezterm.log_info(string.format(
  --         "Active pane process: %s",
  --         tab.active_pane.foreground_process_name or "nil"
  --     ))
  -- end

  -- local index = utf8.char(0x2460 + tab.tab_index)
  local index = tab.tab_index + 1
  local zoomed = ''
  if tab.active_pane.is_zoomed then
      zoomed = ' ⏺'
  end

  local title = " " .. index .. get_tab_title(tab, pane) .. zoomed .. " "
  local color = string_to_color(get_cwd_for_color(tab))

  if tab.is_active then
    return {
        { Attribute = { Intensity = "Bold" } },
        { Background = { Color = color } },
        { Foreground = { Color = select_contrasting_fg_color(color) } },
        { Text = title },
    }
  end
  if has_unseen_output(tab) then
    return {
        -- { Foreground = { Color = "#EBD168" } },
        { Text = title },
    }
  end
  return title
end)
