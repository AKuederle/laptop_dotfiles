-- launch applications
globalkeys = awful.util.table.join(globalkeys,
    -- Mod + F3: Launch webbrowser (chromium)
    awful.key({ modkey, }, "#69", function ()
      local matcher = function (c)
         return awful.rules.match(c, {instance = 'chromium'})
       end
       awful.client.run_or_raise('chromium', matcher)
     end),

    -- Shift + Mod + F3: Force second webbrowser (chromium)
    awful.key({ modkey, "Shift" }, "#69", function () awful.util.spawn_with_shell("chromium") end),

    -- Mod + F2: Launch texteditor (sublime)
    awful.key({ modkey, }, "#68", function ()
      local matcher = function (c)
         return awful.rules.match(c, {class = 'subl3'})
       end
       awful.client.run_or_raise('subl3', matcher)
     end),

    -- Mod + F7: Launch all Chat Apps (Hangouts, Whatsapp, Messenger)
    awful.key({ modkey, }, "#73", function ()
      local matcher = function (c)
         return awful.rules.match(c, { instance = "web.whatsapp.com" })
       end
       awful.client.run_or_raise('WhatsApp', matcher)
      local matcher = function (c)
         return awful.rules.match(c, { instance = "www.messenger.com" })
       end
       awful.client.run_or_raise('Messenger', matcher)
      local matcher = function (c)
         return awful.rules.match(c, { instance = "crx_knipolnnllmklapflnccelgolnpehhpl" })
       end
       awful.client.run_or_raise('Hangouts', matcher)
     end),

    -- Alt + Space: Dashboard terminal
    awful.key({ "Mod1", }, "space", function ()
      local s = mouse.screen
      awful.tag.history.update(screen[s])
      if awful.tag.selected(s) == awful.tag.gettags(s)[10] then
        awful.tag.history.restore(s)
      else
        local matcher = function (c)
           return awful.rules.match(c, {instance = 'dashboard-terminal'})
         end
         awful.client.run_or_raise( terminal .. ' --name="dashboard-terminal"', matcher)
      end   
     end),
    
    awful.key({ modkey, }, "e",      function () awful.util.spawn("thunar") end),
    awful.key({ modkey, }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, }, "d", function () awful.util.spawn("rofi -show combi -combi-modi 'git,window,run'") end),
    awful.key({ modkey, }, "q", function () awful.util.spawn("rofi -show git") end),
    awful.key({ "Control", "Mod1"}, "Delete", function () awful.util.spawn_with_shell("xautolock -locknow") end)
)
-- 

-- Special Keys (Fn + ..)
globalkeys = awful.util.table.join(globalkeys,
    -- if audiokeys are handeld by the volumeicon applet, comment them out. This allows to show popups when changing the volume
    awful.key({ }, "XF86AudioMute",         function () awful.util.spawn_with_shell("amixer -q sset Master toggle") volumewidget:update() end),
    awful.key({ }, "XF86AudioLowerVolume",  function () awful.util.spawn_with_shell("amixer -q sset Master 2%-") volumewidget:update() end),
    awful.key({ }, "XF86AudioRaiseVolume",  function () awful.util.spawn_with_shell("amixer -q sset Master 2%+") volumewidget:update() end),
    awful.key({ }, "XF86AudioMicMute",      function () awful.util.spawn_with_shell("amixer set Capture toggle") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn_with_shell("xbacklight -dec 10") end),
    awful.key({ }, "XF86MonBrightnessUp",   function () awful.util.spawn_with_shell("xbacklight -inc 10") end),
    awful.key({ modkey }, "XF86MonBrightnessDown", function () redshift.toggle() end),
    awful.key({ modkey }, "XF86MonBrightnessUp",   function () redshift.toggle() end),
    awful.key({ }, "XF86Display",           function () end),
    awful.key({ modkey }, "XF86Display",           function () mylockscreenwidget:toggle() end),
    awful.key({ }, "XF86WLAN",              function () awful.util.spawn_with_shell("wifi-toggle") end),
    awful.key({ }, "XF86Search",            function () end),
    awful.key({ }, "XF86LaunchA",           function () end),
    awful.key({ }, "XF86Explorer",          function ()
        local matcher = function (c)
           return awful.rules.match(c, {instance = "trello.com__b_tACplLOR_to-do"})
         end
         awful.client.run_or_raise( "Trello", matcher)
      end),
    -- To make this powerbutton work, powerbutton handling must be set to ingnore in /ect/systemd/logind.conf
    awful.key({ }, "XF86PowerOff",          function () awful.util.spawn_with_shell("shutdown_menu") end)
    
)
--


-- {{{ Key bindings
globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys_all = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "s",      function (c) c.sticky = not c.sticky          end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

clientkeys_extra = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}