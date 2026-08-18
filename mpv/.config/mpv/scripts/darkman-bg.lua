-- darkman-bg.lua
-- Background is forced to #000000 in fullscreen, otherwise follows `darkman get`

local mp = require("mp")
local options = require("mp.options")

local o = {
    darkman_cmd = "darkman get",
    poll_interval = 0.5,

    fullscreen_color = "#000000",

    dark_color  = "#181818",
    light_color = "#fbf1c7",
}

options.read_options(o, "darkman-bg")

local current_mode = nil      -- "dark" or "light"
local current_color = nil    -- hex string
local is_fullscreen = false

local function run_darkman_get()
    local f = io.popen(o.darkman_cmd)
    if not f then return nil end
    local out = f:read("*a") or ""
    f:close()

    out = out:lower()
    if out:find("dark", 1, true) then
        return "dark"
    elseif out:find("light", 1, true) then
        return "light"
    end
    return nil
end

local function apply_background(mode)
    -- If fullscreen: always black
    if is_fullscreen then
        if current_color ~= o.fullscreen_color then
            mp.set_property("background", "color")
            mp.set_property("background-color", o.fullscreen_color)
            current_color = o.fullscreen_color
        end
        return
    end

    -- Otherwise follow darkman
    local color = (mode == "dark") and o.dark_color or o.light_color
    if color == current_color then return end

    mp.set_property("background", "color")
    mp.set_property("background-color", color)
    current_color = color
end

local function refresh()
    if is_fullscreen then
        -- keep black while fullscreen; no need to poll
        return
    end

    local mode = run_darkman_get()
    if not mode then return end
    if mode == current_mode then return end

    current_mode = mode
    apply_background(mode)
end

-- Watch fullscreen toggle
mp.observe_property("fullscreen", "bool", function(_, val)
    is_fullscreen = val and true or false
    if current_mode then
        apply_background(current_mode)
    else
        -- First time: ensure correct color immediately
        if is_fullscreen then
            apply_background("dark") -- mode irrelevant in fullscreen
        else
            refresh()
        end
    end
end)

mp.register_event("file-loaded", function()
    refresh()
end)

mp.add_periodic_timer(o.poll_interval, refresh)

-- initial attempt
refresh()
