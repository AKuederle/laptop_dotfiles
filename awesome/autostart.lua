-- Autostart Programms with awesome

-- Function which checks, if programm is running and only launches it if not.
-- modified from https://awesome.naquadah.org/wiki/Autostart (added sleep functionality to control execution order)
-- {{
function run_once(cmd, sleep)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (sleep " .. sleep .. "; " .. cmd .. ")")
end
-- }}


-- List of applications:
run_once("dropbox", 0)
run_once("nm-applet", 2)
--