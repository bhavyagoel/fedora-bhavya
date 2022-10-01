local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local todo_widget = require("widget.todo-widget.todo")
local logout_menu_widget = require("widget.logout-menu-widget.logout-menu")
local calendar_widget = require("widget.calendar-widget.calendar")
local brightness_widget = require("widget.brightness-widget.brightness")
local cpu_widget = require("widget.cpu-widget.cpu-widget")
local docker_widget = require("widget.docker-widget.docker")
local weather_widget = require("widget.weather-widget.weather")
local ram_widget = require("widget.ram-widget.ram-widget")
local mpris_widget = require("widget.mpris-widget")
local net_speed = require("widget.net-speed-widget.net-speed")
local cpu_temp = require("widget.cpu-temp-widget.temperature")

-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- default
-- local cw = calendar_widget()
-- or customized
local cw = calendar_widget({
    theme = 'dark',
    placement = 'top_right',
    start_sunday = true,
    radius = 8,
    -- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3
})

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/custom"
theme.wallpaper = theme.dir .. "/wall.jpg"
theme.font = "Terminus 9"
theme.fg_normal = "#ffffff"
theme.fg_focus = "#EA6F81"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#000000"
theme.bg_focus = "#000000"
theme.bg_menu_focus = "#000000"
theme.bg_urgent = "#000000"
theme.border_width = dpi(1)
theme.border_normal = "#3F3F3F"
theme.border_focus = "#7F7F7F"
theme.border_marked = "#CC9393"
theme.tasklist_bg_focus = "#000000"
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery_full.png"
theme.widget_battery_80 = theme.dir .. "/icons/battery_80.png"
theme.widget_battery_60 = theme.dir .. "/icons/battery_60.png"
theme.widget_battery_40 = theme.dir .. "/icons/battery_40.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_20.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/wifi.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note_on.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.right_arrow = theme.dir .. "/icons/right-arrow.png"
theme.open_bracket = theme.dir .. "/icons/back.png"
theme.close_bracket = theme.dir .. "/icons/right.png"
theme.separator = theme.dir .. "/icons/priority.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(0)
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch("date +'%a %d %b %R'", 60, function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, stdout))
end)

-- Calendar
-- theme.cal = lain.widget.cal({
--     attach_to = { clock },
--     notification_preset = {
--         font = "Terminus 10",
--         fg   = theme.fg_normal,
--         bg   = theme.bg_normal
--     }
-- })

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
-- commented because it needs to be set before use

-- mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
-- theme.mail = lain.widget.imap({
--     timeout  = 180,
--     server   = "smtp.gmail.com",
--     mail     = "bgoel4132@gmail.com",
--     password = "ysnlasiudlistdry",
--     settings = function()
--         if mailcount > 0 then
--             widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
--             mailicon:set_image(theme.widget_mail_on)
--         else
--             widget:set_text("")
--             mailicon:set_image(theme.widget_mail)
--         end
--     end
-- })

-- MPD
local musicplr = awful.util.terminal .. " -title Music -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(awful.button({"Mod4"}, 1, function()
    awful.spawn(musicplr)
end), awful.button({}, 1, function()
    os.execute("mpc prev")
    theme.mpd.update()
end), awful.button({}, 2, function()
    os.execute("mpc toggle")
    theme.mpd.update()
end), awful.button({}, 3, function()
    os.execute("mpc next")
    theme.mpd.update()
end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title = mpd_now.title .. " "
            mpdicon:set_image(theme.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title = "paused "
        else
            artist = ""
            title = ""
            mpdicon:set_image(theme.widget_music)
        end

        widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
    end
})
--]]

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image(theme.widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif tonumber(bat_now.perc) <= 20 then
                baticon:set_image(theme.widget_battery_low)
            elseif tonumber(bat_now.perc) <= 40 then
                baticon:set_image(theme.widget_battery_40)
            elseif tonumber(bat_now.perc) <= 60 then
                baticon:set_image(theme.widget_battery_60)
            elseif tonumber(bat_now.perc) <= 80 then
                baticon:set_image(theme.widget_battery_80)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(theme.font, " AC "))
            baticon:set_image(theme.widget_ac)
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})

theme.volume.widget:buttons(awful.util.table.join(awful.button({}, 4, function()
    awful.util.spawn("amixer set Master 1%+")
    theme.volume.update()
end), awful.button({}, 5, function()
    awful.util.spawn("amixer set Master 1%-")
    theme.volume.update()
end), awful.button({}, 1, function()
    awful.util.spawn("amixer set Master toggle")
    theme.volume.update()
end), awful.button({}, 3, function()
    awful.util.spawn("pavucontrol")
end)))

-- on click mute
volicon:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.util.spawn("amixer set Master toggle")
    theme.volume.update()
end)))

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
            markup("#7AC82E", " " .. string.format("%04.1f", net_now.received)) .. " " ..
                markup("#46A8C3", " " .. string.format("%04.1f", net_now.sent) .. " ")))
    end
})

-- Separators
local spr = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_menu_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_menu_focus)
local right_arrow = wibox.widget.imagebox(theme.right_arrow)
local open = wibox.widget.imagebox(theme.open_bracket)
local close = wibox.widget.imagebox(theme.close_bracket)
local divider = wibox.widget.imagebox(theme.separator)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({
        app = awful.util.terminal
    })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(awful.button({}, 1, function()
        awful.layout.inc(1)
    end), awful.button({}, 2, function()
        awful.layout.set(awful.layout.layouts[1])
    end), awful.button({}, 3, function()
        awful.layout.inc(-1)
    end), awful.button({}, 4, function()
        awful.layout.inc(1)
    end), awful.button({}, 5, function()
        awful.layout.inc(-1)
    end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(18),
        bg = theme.bg_normal,
        fg = theme.fg_normal
    })

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            s.mytaglist,
            s.mypromptbox,
            spr
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mpris_widget(),
            -- wibox.container.background(mpris_widget() , theme.bg_menu_focus),
            spr,
            -- open,
            -- close,
            spr,
            todo_widget(),
            spr,
            -- open,
            -- close,
            spr,
            docker_widget(),
            weather_widget({
                api_key = 'cfdb5aeb5d93464f15d8465330e8f996',
                coordinates = {27.2046, 77.4977},
                time_format_12h = true,
                units = 'metric',
                both_units_widget = true,
                font_name = 'Carter One',
                icons = 'VitalyGorbachev',
                icons_extension = '.svg',
                show_hourly_forecast = true,
                show_daily_forecast = true

            }),
            spr,
            -- open,
            -- close,
            spr,
            volicon,
            theme.volume.widget,
            spr,
            -- open,
            -- close,
            -- spr, 
            ram_widget(),
            mem.widget,
            spr,
            -- open,
            -- close,
            spr,
            cpuicon,
            cpu,
            cpu_widget({
                width = 50,
                step_width = 2,
                step_spacing = 0,
                color = '#434c5e'
            }),
            spr,
            -- open,
            -- close,
            spr,
            tempicon,
            cpu_temp,
            spr,
            -- open,
            -- close,
            spr,
            baticon,
            bat.widget,
            spr,
            -- open,
            -- close,
            spr,
            neticon,
            net_speed(),
            -- open,
            -- close,
            spr,
            clock,
            spr,
            -- open,
            -- close,
            spr,
            s.mylayoutbox,
            logout_menu_widget {
                onlock = function()
                    awful.spawn.with_shell("i3lock  -p win -i ~/Pictures/original.jpg")
                end,
                onlogout = function()
                    awesome.quit()
                end
            }
        }
    }
end

clock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        cw.toggle()
    end
end)

return theme
