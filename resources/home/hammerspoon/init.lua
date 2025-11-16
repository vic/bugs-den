require("hs.ipc")
hs.window.animationDuration = 0.06
PaperWM = hs.loadSpoon("PaperWM")
PaperWM:bindHotkeys({
    -- switch to a new focused window in tiled grid
    focus_left  = {{"ctrl", "alt", "cmd"}, "h"},
    focus_right = {{"ctrl", "alt", "cmd"}, "l"},
    focus_up    = {{"ctrl", "alt", "cmd"}, "k"},
    focus_down  = {{"ctrl", "alt", "cmd"}, "j"},

    -- switch windows by cycling forward/backward
    -- (forward = down or right, backward = up or left)
    focus_prev = {{"ctrl", "alt", "cmd"}, "p"},
    focus_next = {{"ctrl", "alt", "cmd"}, "n"},

    -- move windows around in tiled grid
    swap_left  = {{"ctrl", "alt", "cmd", "shift"}, "h"},
    swap_right = {{"ctrl", "alt", "cmd", "shift"}, "l"},
    swap_up    = {{"ctrl", "alt", "cmd", "shift"}, "k"},
    swap_down  = {{"ctrl", "alt", "cmd", "shift"}, "j"},

    -- position and resize focused window
    center_window        = {{"ctrl", "alt", "cmd"}, "c"},
    full_width           = {{"ctrl", "alt", "cmd"}, "f"},
    cycle_width          = {{"ctrl", "alt", "cmd"}, "r"},
    reverse_cycle_width  = {{"ctrl", "alt", "cmd", "shift"}, "r"},
    cycle_height         = {{"alt", "cmd", "shift"}, "r"},
    reverse_cycle_height = {{"ctrl", "alt", "cmd", "shift"}, "r"},

    -- increase/decrease width
    increase_width = {{"ctrl", "alt", "cmd"}, "right"},
    decrease_width = {{"ctrl", "alt", "cmd"}, "left"},

    -- move focused window into / out of a column
    slurp_in = {{"ctrl", "alt", "cmd", "shift"}, "i"},
    barf_out = {{"ctrl", "alt", "cmd", "shift"}, "o"},

    -- move the focused window into / out of the tiling layer
    toggle_floating = {{"alt", "cmd", "ctrl"}, "escape"},

    -- focus the first / second / etc window in the current space
    -- focus_window_1 = {{"alt", "cmd", "ctrl"}, "1"},
    -- focus_window_2 = {{"alt", "cmd", "ctrl"}, "2"},
    -- focus_window_3 = {{"alt", "cmd", "ctrl"}, "3"},
    -- focus_window_4 = {{"alt", "cmd", "ctrl"}, "4"},
    -- focus_window_5 = {{"alt", "cmd", "ctrl"}, "5"},
    -- focus_window_6 = {{"alt", "cmd", "ctrl"}, "6"},
    -- focus_window_7 = {{"alt", "cmd", "ctrl"}, "7"},
    -- focus_window_8 = {{"alt", "cmd", "ctrl"}, "8"},
    -- focus_window_9 = {{"alt", "cmd", "ctrl"}, "9"},

    -- switch to a new Mission Control space
    switch_space_l = {{"ctrl", "alt", "cmd"}, ","},
    switch_space_r = {{"ctrl", "alt", "cmd"}, "."},
    switch_space_1 = {{"ctrl", "alt", "cmd"}, "1"},
    switch_space_2 = {{"ctrl", "alt", "cmd"}, "2"},
    switch_space_3 = {{"alt", "cmd"}, "3"},
    switch_space_4 = {{"alt", "cmd"}, "4"},
    switch_space_5 = {{"alt", "cmd"}, "5"},
    switch_space_6 = {{"alt", "cmd"}, "6"},
    switch_space_7 = {{"alt", "cmd"}, "7"},
    switch_space_8 = {{"alt", "cmd"}, "8"},
    switch_space_9 = {{"alt", "cmd"}, "9"},

    -- move focused window to a new space and tile
    move_window_1 = {{"alt", "cmd", "ctrl", "shift"}, "1"},
    move_window_2 = {{"alt", "cmd", "ctrl", "shift"}, "2"},
    move_window_3 = {{"alt", "cmd", "shift"}, "3"},
    move_window_4 = {{"alt", "cmd", "shift"}, "4"},
    move_window_5 = {{"alt", "cmd", "shift"}, "5"},
    move_window_6 = {{"alt", "cmd", "shift"}, "6"},
    move_window_7 = {{"alt", "cmd", "shift"}, "7"},
    move_window_8 = {{"alt", "cmd", "shift"}, "8"},
    move_window_9 = {{"alt", "cmd", "shift"}, "9"}
})
PaperWM.window_gap = 4
PaperWM.drag_window = { "ctrl", "alt", "cmd" }
PaperWM.lift_window = { "ctrl", "alt", "cmd", "shift" }
PaperWM.swipe_fingers = 3
PaperWM:start()
ActiveSpace = hs.loadSpoon("ActiveSpace")
ActiveSpace.compact = true
ActiveSpace:start()
