-- ror.lua
-- This is the file goes in your ~/.config/awesome/ directory
-- It contains your table of 'run or raise' key bindings for aweror.lua
-- Table entry format: ["key"]={"function", "match string", "optional attribute to match"}
-- The "key" will be bound as "modkey + key".
-- The "function" is what gets run if no matching client windows are found.
-- Usual attributes are "class","instance", or "name". If no attribute is given it defaults to "class".
-- The "match string"  will match substrings.  So "Firefox" will match "blah Firefox blah"  
-- Use xprop to get this info from a window.  WM_CLASS(STRING) gives you "instance", "class".  WM_NAME(STRING) gives you the name of the selected window (usually something like the web page title for browsers, or the file name for emacs).

module("ror")
table5={
	 ["g"]={"gimp","Gimp"},  
	 ["b"]={"luakit","luakit"},  
   ["n"]={"nautilus","Nautilus"},
   ["t"]={"urxvt -e tmux","URxvt"},
   ["r"]={"gmrun","Gmrun"},
   ["c"]={"chromium","Chromium"},
   ["w"]={"/usr/lib/virtualbox/VirtualBox --comment Windoze --startvm 9112bdaa-21ef-4092-a5d9-a4c52e18f520 --no-startvm-errormsgbox", "VirtualBox"},
	 ["v"]={"gpicview","Gpicview"},
}
