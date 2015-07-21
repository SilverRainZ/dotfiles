import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor
import System.IO

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

myWorkspaces = ["web", "code", "term", "im", "ext", "", "", "", "min"]
myManageHook = manageDocks <+> manageHook defaultConfig

myLoyoutHook = avoidStruts  $  layoutHook defaultConfig

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
        -- Key bind
        `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e \'mv $f ~/Pictures/Screenshots/\'")
        , ((0, xK_Print), spawn "scrot -e \'mv $f ~/Pictures/Screenshots/\'")
        ]

