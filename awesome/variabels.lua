-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
terminal = "termite -e /bin/zsh"
editor = os.getenv("EDITOR") or "subl3"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- Table of tag names displayed
tag_names = { "main", "work", "www", "mail", 5, 6, "chat", 8, 9, "#" }

-- Redshift configuration
redshift.options = "-t 6500:3600 -r"
redshift.init(1)
-- }}}