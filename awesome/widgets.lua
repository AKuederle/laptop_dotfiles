local wibox = require("wibox")
-- {{{ Wibox

-- Create a 4 space seperator
fourspaces = wibox.widget.textbox()
fourspaces:set_text("    ")

-- Create a 1 space seperator
space = wibox.widget.textbox()
space:set_text(" ")
-- Create a textclock widget
mytextclock = awful.widget.textclock("%H:%M")

-- attach a calender pop-up to the texclock
lain.widgets.calendar:attach(mytextclock, {font = "inconsolata"})

-- create an audio widget
local function volwidget( )
  local volumewidget = wibox.widget.textbox()
  volumewidgettimer = timer({ timeout = 5 })
  volumewidget:set_markup("%")
  volumewidget.update = function ()
    local vol_info = awful.util.pread("amixer sget Master | gawk 'match($0, /Front Left:.*?\\[(.*?)%] \\[(.*?)]/, a) {print a[1],a[2]}'")
    local temp = {}
    for match in vol_info:gmatch("%w+") do table.insert(temp, match) end
    local vol = temp[1]
    local state = temp[2]
    local text = ""
    if tonumber(vol) == 100 then
      text = "MAX"
    else
      text = vol .. "%"
    end
    if state:find("off") then
      text = markup.fg.color("#E63E10", text)
    end
    volumewidget:set_markup( text )
  end
  volumewidgettimer:connect_signal("timeout", volumewidget.update)
  volumewidgettimer:start()
  volumewidget:update()
  return volumewidget
end

myvoltext = wibox.widget.textbox()
myvoltext:set_markup(markup.bold("VOL "))
volumewidget = volwidget()
mixer_button = awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end)
volumewidget:buttons( mixer_button )
myvoltext:buttons( mixer_button )

-- create a batterywidget
local function batwidget( number )
  local batterywidget = wibox.widget.textbox()    
  batterywidget:set_text("Battery" .. tostring(number))    
  batterywidgettimer = timer({ timeout = 3 })
  batterywidget.update = function()
    local bat_info = awful.util.pread("acpi | gawk 'match($0, /Battery " .. number .. ": (.*?), (.*?)%/, a) {print a[1],a[2]}'")
    local temp = {}
    for match in bat_info:gmatch("%w+") do table.insert(temp, match) end
    local bat_perc = temp[2]
    local bat_stat = temp[1]
    local ac_stat  = awful.util.pread("acpi -a")
    local text = bat_perc:gsub('\n', '') .. "%"
    if tonumber(bat_perc) < 10 then
      text = " " .. text
    elseif tonumber(bat_perc) == 100 then
      text = "MAX"
    end
    if bat_stat:find("Charging") then
      text = markup.fg.color("#20E337", text)
    elseif ac_stat:find("on") then
      text = markup.fg.color("#F5A111", text)
    elseif tonumber(bat_perc) <= 30 then
      text = markup.fg.color("#E63E10", text)
    end
    batterywidget:set_markup(text)
  end 
  batterywidgettimer:connect_signal("timeout", batterywidget.update) 
  batterywidgettimer:start()
  batterywidget:update()
  return batterywidget
end

mybattext = wibox.widget.textbox()
mybattext:set_markup(markup.bold("BAT"))
mybat1 = batwidget(0)
mybat2 = batwidget(1)

mywibox = {}
mypromptbox = {}
mylayoutbox = {}

-- Add mousekeybindings for the taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )

-- Add mousekeybindings for the tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- Create a wibox for each screen and add it

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox (replace hieight with theme paramter)
    mywibox[s] = awful.wibox({ position = "top", screen = s , height = "22" })
    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(fourspaces)
    right_layout:add(myvoltext)
    right_layout:add(volumewidget)
    right_layout:add(fourspaces)
    right_layout:add(mybattext)
    right_layout:add(space)
    right_layout:add(mybat1)
    right_layout:add(space)
    right_layout:add(mybat2)
    right_layout:add(fourspaces)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}