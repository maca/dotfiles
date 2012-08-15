---------------------------
-- Default awesome theme --
---------------------------

theme  = {}
home   = os.getenv("HOME")
config = awful.util.getdir("config")

-- theme.font          = "sans 9"
theme.bg_normal     = "#080808"
theme.bg_focus      = "#1a1a1a"
theme.bg_urgent     = "#441111"
theme.bg_minimize   = "#080808"

theme.fg_normal     = "#444444"
theme.fg_focus      = "#acad7f"
theme.fg_urgent     = "#aa8888"
theme.fg_minimize   = "#888888"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#343421"
theme.border_marked = "#000000"

-- theme.tooltip_font         = "Droid Sans 11"
-- theme.tooltip_bg_color     = "330000"
-- theme.tooltip_fg_color     = "a30000"
-- theme.tooltip_border_width = "1"
-- theme.tooltip_border_color = "a30000"
-- theme.tooltip_opacity      = "100"

theme.taglist_squares = true
naughty.config.presets.critical.fg           = "#a30000"
naughty.config.presets.critical.bg           = "#330000"
naughty.config.presets.critical.border_color = "#a30000"

-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "hsetroot -solid '#ffffff' -tile /secondary/Images/deckard+rachel.jpg -full /secondary/Images/deckard+rachel.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh      = "/home/maca/dotfiles/awesome/themes/maca/layouts/fairhw.png"
theme.layout_fairv      = "/home/maca/dotfiles/awesome/themes/maca/layouts/fairvw.png"
theme.layout_floating   = "/home/maca/dotfiles/awesome/themes/maca/layouts/floatingw.png"
theme.layout_magnifier  = "/home/maca/dotfiles/awesome/themes/maca/layouts/magnifierw.png"
theme.layout_max        = "/home/maca/dotfiles/awesome/themes/maca/layouts/maxw.png"
theme.layout_fullscreen = "/home/maca/dotfiles/awesome/themes/maca/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/maca/dotfiles/awesome/themes/maca/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/maca/dotfiles/awesome/themes/maca/layouts/tileleftw.png"
theme.layout_tile       = "/home/maca/dotfiles/awesome/themes/maca/layouts/tilew.png"
theme.layout_tiletop    = "/home/maca/dotfiles/awesome/themes/maca/layouts/tiletopw.png"
theme.layout_spiral     = "/home/maca/dotfiles/awesome/themes/maca/layouts/spiralw.png"
theme.layout_dwindle    = "/home/maca/dotfiles/awesome/themes/maca/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
