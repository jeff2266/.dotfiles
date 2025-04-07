-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where you actually apply your config choices
-- Use default domain instead of default prog so current working 
-- directory can be passed to new sessions
-- config.default_prog = { "ubuntu.exe" }
config.default_domain = "WSL:Ubuntu"
config.launch_menu = {
    {
        -- Optional label to show in the launcher. If omitted, a label
        -- is derived from the `args`
        label = "Powershell",

        -- The argument array to spawn.  If omitted the default program
        -- will be used as described in the documentation above
        args = { "powershell.exe" },
    
        -- You can specify an alternative current working directory;
        -- if you don't specify one then a default based on the OSC 7
        -- escape sequence will be used (see the Shell Integration
        -- docs), falling back to the home directory.
        -- cwd = "/some/path"
        domain = { DomainName = "local" }
    
        -- You can override environment variables just for this command
        -- by setting this here.  It has the same semantics as the main
        -- set_environment_variables configuration option described above
        -- set_environment_variables = { FOO = "bar" },
    },
}
config.leader = { key = "a", mods = "CTRL" }
config.keys = {
    {
        key = "RightArrow",
        mods = "LEADER",
        action = act.SplitHorizontal {
            domain = "CurrentPaneDomain"
        },
    },
    {
        key = "DownArrow",
        mods = "LEADER",
        action = act.SplitVertical {
            domain = "CurrentPaneDomain"
        },
    },
    {
        key = "z",
        mods = "LEADER",
        action = act.TogglePaneZoomState,
    },
    {
        key = "a",
        mods = "LEADER",
        action = act.ActivatePaneDirection "Next"
    },
    {
        key = "Space",
        mods = "LEADER",
        -- Activate the `resize_panes` keytable
        action = wezterm.action.ActivateKeyTable {
        name = "resize_panes",
        -- Ensures the keytable stays active after it handles its
        -- first keypress.
        one_shot = false,
        -- Deactivate the keytable after a timeout.
        timeout_milliseconds = 1000,
        }
    },
    {
        key = "d",
        mods = "LEADER",
        action = act.CloseCurrentPane { confirm = true },
    },
    {
        key = "z",
        mods = "LEADER",
        action = act.TogglePaneZoomState,
    },
    {
        key = "t",
        mods = "LEADER",
        action = act.ShowLauncher,
    },
}
config.key_tables = {
    resize_panes = {
        { key = "LeftArrow", action = act.AdjustPaneSize { "Left", 8 } },
        { key = "RightArrow", action = act.AdjustPaneSize { "Right", 4 } },
        { key = "UpArrow", action = act.AdjustPaneSize { "Up", 8 } },
        { key = "DownArrow", action = act.AdjustPaneSize { "Down", 4 } },
        { key = 'Escape', action = 'PopKeyTable' },
    },
}
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
    font_size = 11.0,
}
config.font = wezterm.font {
    family = "FiraCode Nerd Font",
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
}
config.color_scheme = "tokyonight"
config.color_schemes = {
    ["tokyonight"] = {
        background = "black"
    }
}
config.window_background_opacity = 0.85

-- and finally, return the configuration to wezterm
return config