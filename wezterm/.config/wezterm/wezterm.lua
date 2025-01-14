-- Ref: https://alexplescan.com/posts/2024/08/10/wezterm/
-- https://github.com/wez/wezterm/discussions/3901#discussioncomment-9884262
local wezterm = require 'wezterm'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save({ interval_seconds = 15 * 60, save_windows = true })

--- Utility functions
function Scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'OneHalfDark'
  else
    return 'OneHalfLight'
  end
end

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'SUPER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

wezterm.on('toggle-colorscheme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.color_scheme then
    overrides.color_scheme = 'OneHalfLight'
  else
    overrides.color_scheme = nil
  end
  window:set_config_overrides(overrides)
end)

--- Add zoom indicator to tab title
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  return tab_info.active_pane.title
end

function on_format_tab_title(tab, _tabs, _panes, _config, _hover, _max_width)
  local zoomed = ''
  local index = tab.tab_index + 1
  local title = tab_title(tab)
  if tab.active_pane.is_zoomed then
    zoomed = '⏺ '
  end
  return {{ Text = string.format(' %d %s%s ', index, zoomed, title) }}
end

wezterm.on('format-tab-title', on_format_tab_title)

--- Notify on session resurrect and save or failure
function emit_message_status(window, msg)
  local current_color_scheme = window:effective_config().resolved_palette
  window:set_right_status(wezterm.format {
    { Foreground = { Color = current_color_scheme.background }},
    { Background = { Color = current_color_scheme.foreground }},
    { Text = msg }
  })
  wezterm.time.call_after(2, function()
    window:set_right_status(wezterm.format {
      { Text = '' }
    })
  end)
end

local last_win = nil
wezterm.on('update-right-status', function(window, pane)
  last_win = window
end)

local is_periodic_save = false
wezterm.on("resurrect.periodic_save", function()
  is_periodic_save = true
end)

wezterm.on("resurrect.error", function(err)
  if last_win then
    wezterm.log_error("ERROR!")
    emit_message_status(last_win, ' err ')
  end
end)

wezterm.on('resurrect.save_state.finished', function(...)
  if last_win then
    if is_periodic_save then
      is_periodic_save = false
      emit_message_status(last_win, ' Periodic Save ')
    else
      emit_message_status(last_win, ' Resurrect: Saved ')
    end
  end
end)

wezterm.on('resurrect.window_state.restore_window.finished', function()
  if last_win then
    emit_message_status(last_win, ' Resurrect: Restored ')
  end
end)

--- Setup
return {
  scrollback_lines = 10000,
  -- fonts
  font = wezterm.font_with_fallback {
    { family = 'Victor Mono', weight = 'DemiBold' },
    { family = 'Symbols Nerd Font Mono', scale = 0.90 },
  },
  font_size = 14.0;
  line_height = 1.15,
  underline_position = -9,
  underline_thickness = '150%',
  use_cap_height_to_scale_fallback_fonts = true,
  allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace',
  -- theme
  color_scheme = Scheme_for_appearance(wezterm.gui.get_appearance()),
  color_schemes = {
    ["OneHalfDark"] = {
      background = '#282C33',
      foreground = '#FFFFFF',  
      cursor_border = '#00C2FF',
      cursor_bg = '#00C2FF',
      tab_bar = {
        background = 'rgba(0,0,0,0)',
        active_tab = {
          bg_color = 'rgba(0,0,0,0)',
          fg_color = '#ffffff',
        },
      },
      ansi = {
        '#30343d',  -- black (subtle-color dark)
        '#c47779',  -- red (red-color dark)
        '#a7bf87',  -- green (green-color dark)
        '#d9c18c',  -- yellow (yellow-color dark)
        '#81a2be',  -- blue (blue-color dark)
        '#b294bb',  -- magenta (magenta-color dark)
        '#7db2bd',  -- cyan (cyan-color dark)
        '#cccccc',  -- white (foreground-color dark)
      },
      brights = {
        '#848993',  -- bright black (inactive-color dark)
        '#c47779',  -- bright red (same as normal)
        '#a7bf87',  -- bright green (same as normal)
        '#d9c18c',  -- bright yellow (same as normal)
        '#81a2be',  -- bright blue (same as normal)
        '#b294bb',  -- bright magenta (same as normal)
        '#7db2bd',  -- bright cyan (same as normal)
        '#ffffff',  -- bright white
      },
    },
    ["OneHalfLight"] = {
      background = '#f7f7f7',
      foreground = '#1A1A1A',  
      cursor_border = '#00C2FF',
      cursor_bg = '#00C2FF',
      tab_bar = {
        background = 'rgba(0,0,0,0)',
        active_tab = {
          bg_color = 'rgba(0,0,0,0)',
          fg_color = '#1a1a1a',
        },
        inactive_tab = { bg_color = '#e0e3ed', fg_color = '#5e636a' },
        new_tab = { bg_color = '#e0e3ed', fg_color = '#5e636a' },
        new_tab_hover = { bg_color = '#e0e3ed', fg_color = '#5e636a', italic = true },
        inactive_tab_hover = { bg_color = '#e0e3ed', fg_color = '#5e636a', italic = true },
      },
      ansi = {
        '#EEEEEE',  -- black (subtle-color light)
        '#c56655',  -- red (red-color light)
        '#5f8700',  -- green (green-color light)
        '#bb9200',  -- yellow (yellow-color light)
        '#6079db',  -- blue (blue-color light)
        '#7646c1',  -- magenta (magenta-color light)
        '#6594bd',  -- cyan (cyan-color light)
        '#1a1a1a',  -- white (foreground-color light)
      },
      brights = {
        '#5e636e',  -- bright black (inactive-color light)
        '#c56655',  -- bright red (same as normal)
        '#5f8700',  -- bright green (same as normal)
        '#eab700',  -- bright yellow (light-yellow-color light)
        '#6079db',  -- bright blue (same as normal)
        '#7646c1',  -- bright magenta (same as normal)
        '#6594bd',  -- bright cyan (same as normal)
        '#000000',  -- bright white
      },
    },
  },
  -- command palette
  window_frame = {
      font = wezterm.font("Fira Sans"),
  },
  command_palette_rows = 10,
  ui_key_cap_rendering = 'Emacs',
  -- window and UI
  max_fps = 240,
  default_cursor_style = "BlinkingBlock",
  cursor_thickness = "0.1cell",
  cursor_blink_rate = 800,
  text_background_opacity = 0.98,
  window_background_opacity = 0.98,
  macos_window_background_blur = 10,
  window_decorations = "RESIZE",
  window_close_confirmation = 'NeverPrompt',
  adjust_window_size_when_changing_font_size = false,
  -- enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  tab_max_width = 32,
  window_padding = { left = '1cell', right = '1cell', top = '0.6cell', bottom = 0, },
  -- keyboard
  enable_kitty_keyboard = true,
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,
  -- Shortcuts
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 's',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'c',
      mods = 'LEADER',
      action = wezterm.action.ActivateCopyMode
    },
    move_pane('DownArrow', 'Down'),
    move_pane('UpArrow', 'Up'),
    move_pane('LeftArrow', 'Left'),
    move_pane('RightArrow', 'Right'),
    { -- TODO reload pane on zoom toggle
      key = 'z',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = '6',
      mods = 'LEADER',
      action = wezterm.action.EmitEvent 'toggle-colorscheme',
    },
    {
      key = 'a',
      mods = 'LEADER',
      action = wezterm.action.AttachDomain 'unix',
    },
    {
      key = 'd',
      mods = 'LEADER',
      action = wezterm.action.DetachDomain { DomainName = 'unix' },
    },
    {
      key = ',',
      mods = 'LEADER',
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(
          function(window, pane, line)
            if line then
              window:active_tab():set_title(line)
            end
          end
        ),
      },
    },
    {
      key = 'w',
      mods = 'LEADER',
      action = wezterm.action.ShowTabNavigator,
    },
    {
      key="x",
      mods="LEADER",
      action = wezterm.action{ CloseCurrentPane = { confirm = true }}
    },
    {
      key = "Space",
      mods = "LEADER",
      action = wezterm.action.RotatePanes "Clockwise"
    },
    -- Don't intercept these keys
    {
      key = 'Tab',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'Tab', mods = 'CTRL' },
    },
    {
      key = 'Tab',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SendKey { key = 'Tab', mods = 'CTRL|SHIFT' },
    },
    {
      key = 'a',
      mods = 'LEADER|CTRL',
      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },
    -- resurrect
    {
      key = "s",
      mods = "LEADER|CTRL",
      action = resurrect.window_state.save_window_action(),
      -- action = wezterm.action_callback(function(win, pane)
      --   -- resurrect.save_state(resurrect.workspace_state.get_workspace_state())
      --   resurrect.window_state.save_window_action()
      --   resurrect.tab_state.save_tab_action()
      -- end),
    },
    {
      key = "r",
      mods = "LEADER|CTRL",
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, "^([^/]+)") -- match before '/'
          id = string.match(id, "([^/]+)$") -- match after '/'
          id = string.match(id, "(.+)%..+$") -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            -- Ref: https://github.com/MLFlexer/resurrect.wezterm/issues/70#issuecomment-2495838159
            -- tab = win:active_tab(), -- <- FIXME to restore wins in the active tab itself
          }
          if type == "workspace" then
            local state = resurrect.load_state(id, "workspace")
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == "window" then
            local state = resurrect.load_state(id, "window")
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == "tab" then
            local state = resurrect.load_state(id, "tab")
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
    {
      key = "d",
      mods = "LEADER|CTRL",
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id)
          resurrect.delete_state(id)
          end,
          {
            title = "Delete State",
            fuzzy_description = "State to Delete [Enter: accept, Esc: cancel, /: filter] ",
            description = "Search State to Delete: ",
            is_fuzzy = true,
          })
      end),
    },
  },
  -- mux
  unix_domains = {
    { name = 'unix', no_serve_automatically = true, },
  },
  default_domain = 'unix',
  -- term
  -- default_prog = { '~/.nix-profile/bin/fish', '-l' },
  -- term = "wezterm",
}

--- Archived?
-- wezterm.on('window-config-reloaded', function(window)
--   window:maximize()
-- end)

-- wezterm.on('mux-startup', function(cmd)
--   -- Don't spawn a window if we have connected to an existing domain
--   -- if wezterm.mux.get_window() == nil then
--   --   local _, _, window = wezterm.mux.spawn_window(cmd or {
--   --     domain = { DomainName = 'unix' }
--   --   })
--   -- else
--   window = wezterm.mux.get_window()
--   window:maximize()
--   -- end
-- end)

-- Ref: https://github.com/lucaszebrowsky/dotfiles/blob/main/wezterm/wezterm.lua
-- local function getTabTitle(tab_info)
-- 	local processName = tab_info.active_pane.foreground_process_name
-- 	return string.gsub(processName, '(.*[/\\])(.*)', '%2')
-- end
