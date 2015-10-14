import System.IO

import XMonad
import XMonad.ManageHook

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

myTerminal = "konsole"

myModMask = mod4Mask

myFocuseFollowsMouse = True
-- Border
myBorderWidth = 2
myNormalBorderColor = "#cccccc"
myFocusedBorderColor = "#00ffff"

myStartupHook = do
    setDefaultCursor xC_left_ptr
    -- Startup script
    spawn "~/.xmonad/startup.sh"

myWorkspaces = ["web", "code", "term", "im", "doc", "fm", "ext", "", "min"]

myManageHook = composeAll
    [ isFullscreen              --> doFloat
    , className =? "feh"        --> doCenterFloat
    , className =? "MPlayer"    --> doCenterFloat
    , className =? "trayer"     --> doIgnore
    -- , className =? "Wine"       --> doIgnore
    , className =? "Firefox"    --> doShift "web" 
    , className =? "Gvim"       --> doShift "code"
    , className =? "qTox"       --> doShift "im"
    , className =? "konsole"    --> doShift "term"
    ] 

-- myManageHook = manageDocks <+> manageHook defaultConfig

myLoyoutHook = avoidStruts  $  layoutHook defaultConfig

myLogHook xmproc = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 0
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
        -- Key bind
        `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e \'mv $f ~/Pictures/Screenshots/\'")
        , ((0, xK_Print), spawn "scrot -e \'mv $f ~/Pictures/Screenshots/\'")
        ]

