import System.IO

import XMonad
import XMonad.ManageHook

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

myTerminal = "terminator"

myModMask = mod4Mask

myFocuseFollowsMouse = True
-- Border
myBorderWidth = 2
myNormalBorderColor = "#cccccc"
myFocusedBorderColor = "#00ffff"

myStartupHook = do
    setDefaultCursor xC_left_ptr
    -- Startup script
    -- spawn "~/.xmonad/startup.sh"

myWorkspaces = ["web", "code", "term", "im", "doc", "fm", "game", "vbox", "min"]

myManageHook = composeAll
    [ isFullscreen              --> doFloat
    , className =? "Dia"        --> doFloat
    , className =? "feh"        --> doCenterFloat
    , className =? "MPlayer"    --> doCenterFloat
    , className =? "Zenity"     --> doCenterFloat
    , className =? "burp-StartBurp"                     --> doCenterFloat
    , className =? "trayer"     --> doIgnore
    -- , className =? "Wine"       --> doIgnore
    , className =? "Firefox"    --> doShift "web" 
    , className =? "Gvim"       --> doShift "code"
    , className =? "qTox"       --> doShift "im"
    , className =? "Telegram"   --> doShift "im"
    , className =? "terminator"                         --> doShift "term"
    , className =? "Okular"     --> doShift "doc"
    , className =? "Wps"        --> doShift "doc"
    , className =? "Wpp"        --> doShift "doc"
    , className =? "Et"         --> doShift "doc"
    , className =? "dolphin"    --> doShift "fm"
    , className =? "DDNet"      --> doShift "game"
    , className =? "teeworlds"  --> doShift "game"
    , className =? "net-minecraft-bootstrap-Bootstrap"  --> doShift "game"
    , className =? "Minecraft 1.8"                      --> doShift "game"
    , className =? "VirtualBox" --> doShift "vbox"
    ] 

-- myManageHook = manageDocks <+> manageHook defaultConfig

myLoyoutHook = avoidStruts $ layoutHook defaultConfig

myLogHook xmproc = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/la/.xmobarrc"
    xmonad $ defaultConfig 
        { modMask = myModMask
        , terminal = myTerminal
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , workspaces = myWorkspaces
        , startupHook = myStartupHook
        , manageHook = myManageHook
        , layoutHook = myLoyoutHook
        , logHook = myLogHook xmproc
        } 
