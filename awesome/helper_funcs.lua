-- Custom Functions to do some stuff

function change_backlight( arg )
    awful.util.spawn_with_shell("xbacklight " .. arg)
    if light_note then
        naughty.destroy(light_note)
    end
    os.execute("sleep 0.1")
    light_note = naughty.notify({title = "Backlight" ,text = string.format("%.1f",awful.util.pread("xbacklight -get")) .. " %", timeout=1})
end