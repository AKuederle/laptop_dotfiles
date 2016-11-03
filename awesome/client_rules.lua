-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = awful.util.table.join(clientkeys_all, clientkeys_extra),
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 3(www) of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][3] } },
    -- Set Thunderbird to always map on tags number 4(mail) of screen 1.
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[1][4], switchtotag = true } },
    -- Set Chromium to always map on tags number 3(www) of screen 1.
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][3], switchtotag = true } },
    -- Set Sublime to always map on tags number 2(work) of screen 1.
    { rule = { class = "Subl3" },
      properties = { tag = tags[1][2], switchtotag = true } },
    -- Set Whatsapp to always map on tags number 7(chat) of screen 1.
    { rule = { instance = "web.whatsapp.com" },
      properties = { tag = tags[1][7] } },
    -- Set Messenger to always map on tags number 7(chat) of screen 1.
    { rule = { instance = "www.messenger.com" },
      properties = { tag = tags[1][7] } },
    -- Set Hangouts to always map on tags number 7(chat) of screen 1.
    { rule = { instance = "crx_knipolnnllmklapflnccelgolnpehhpl" },
      properties = { tag = tags[1][7], sticky = false }},

    { rule = { instance = "dashboard-terminal" },
      properties = { tag = tags[1][10], keys = clientkeys_all, switchtotag = true }},  

    { rule = { instance = "trello.com__b_tACplLOR_to-do" },
      properties = { tag = tags[1][10], keys = clientkeys_all, switchtotag = true }},  
}
-- }}}
