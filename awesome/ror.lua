-- ROR.LUa
-- This is the file goes in your ~/.config/awesome/ directory
-- It contains your table of 'run or raise' key bindings for aweror.lua
-- Table entry format: ["key"]={"function", "match string", "optional attribute to match"}
-- The "key" will be bound as "modkey + key".
-- The "function" is what gets run if no matching client windows are found.
-- Usual attributes are "class","instance", or "name". If no attribute is given it defaults to "class".
-- The "match string"  will match substrings.  So "Firefox" will match "blah Firefox blah"
-- Use xprop to get this info from a window.  WM_CLASS(STRING) gives you "instance", "class".  WM_NAME(STRING) gives you the name of the selected window (usually something like the web page title for browsers, or the file name for emacs).

table5={
   ["n"]={"spacefm", "spacefm", "instance"},

   ["t"]={"urxvt -name t1 -title t1 -e /home/maca/bin/tmux-attach t1","t1", "instance"},
   ["y"]={"urxvt -name t2 -title t2 -e /home/maca/bin/tmux-attach t2","t2", "instance"},
   ["u"]={"urxvt -name t3 -title t3","t3", "instance"},
   ["h"]={"urxvt -name house -e /bin/zsh -i -c /home/maca/bin/connect-to-house", "house", "instance"},
   ["l"]={"urxvt -name linode -title linode -e /bin/zsh -i -c /home/maca/bin/connect-to-linode", "linode", "instance"},
   ["e"]={"urxvt -name vim -title vim -e vim --servername STANDALONE", "vim", "instance"},

   ["m"]={"urxvt -name cmus -e /bin/zsh -i -c /home/maca/bin/music-player", "cmus", "instance"},
   ["c"]={"urxvt -name centerim -title centerim -e centerim5","centerim", "instance"},
   ["i"]={"urxvt -name weechat -title weechat -e weechat-curses","weechat", "instance"},

   ["r"]={"gmrun","Gmrun"},
   ["b"]={"chromium", "Chromium"},
   ["w"]={"/usr/lib/virtualbox/VirtualBox --comment Windoze --startvm 9112bdaa-21ef-4092-a5d9-a4c52e18f520 --no-startvm-errormsgbox", "VirtualBox"},
	 ["v"]={"gpicview","gpicview"},
	 ["s"]={"spotify","spotify"},
}
