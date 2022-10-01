local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local ICON_DIR = '.'

-- Configuration
local update_interval = 15 -- in seconds

local temperature = wibox.widget {
    {
        id = "temp",
        text = "?? °C",
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    margins = 4,
    widget = wibox.container.margin
}

-- get tempeature of all sensors and store as json
local data = [[bash -c sensors]]

temperature:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then
        awful.spawn.easy_async(data, function(stdout, stderr, reason, exit_code)
            local popup = awful.popup {
                widget = {
                    {
                        {
                            {
                                text = stdout,
                                widget = wibox.widget.textbox
                            },
                            margins = 10,
                            widget = wibox.container.margin
                        },
                        bg = beautiful.bg_normal,
                        shape = gears.shape.rounded_rect,
                        widget = wibox.container.background
                    },
                    margins = 10,
                    widget = wibox.container.margin
                },
                border_color = beautiful.bg_focus,
                border_width = 1,
                placement = function(c)
                    awful.placement.bottom_right(c, {
                        margins = {
                            right = 100,
                            bottom = 600
                        }
                    })

                end,
                ontop = true,
                visible = true,
                shape = gears.shape.rounded_rect
            }
            gears.timer {
                timeout = 5,
                autostart = true,
                single_shot = true,
                callback = function()
                    popup.visible = false
                end
            }
            temperature:connect_signal("mouse::leave", function()
                popup.visible = false
            end)
        end)
    end
end)


local function update_widget(temp)
    temperature:get_children_by_id('temp')[1].markup = temp
end

local temp_script = [[
  bash -c "
  sensors | grep Package | awk '{print $4}' | cut -c 2-3,6-8
  "]]

awful.widget.watch(temp_script, update_interval, function(widget, stdout)
    local temp = stdout
    temp = string.gsub(temp, '^%s*(.-)%s*$', '%1')
    update_widget(temp)
end)

return temperature
