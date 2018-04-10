import           System.IO
import           XMonad
import           XMonad.Actions.CycleWS

import           XMonad.Config.Kde
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Layout
import           XMonad.Layout.DragPane
import           XMonad.Layout.Gaps
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Simplest
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Spacing
import           XMonad.Layout.ToggleLayouts
import           XMonad.Layout.TwoPane
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import qualified XMonad.StackSet             as W
import           XMonad.Util.EZConfig        (additionalKeys)
import           XMonad.Util.Run             (spawnPipe)

import           Data.List
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.SpawnOnce

import           XMonad.Actions.SpawnOn
term = "urxvt"
editor = "code"
main = do
  --xmproc <- spawnPipe "xmobar"
  xsetroot <- spawnPipe "xsetroot -cursor_name left_ptr"
  --xsettingsd <- spawnPipe "xsettingsd"
--  compositor <- spawnPipe "compton --config ~/.compton"
  xmproc   <- spawnPipe "xmobar ~/.xmonad/xmobarrc.hs"
  xmonad
    $                ewmh
    $                docks def
                       { manageHook = manageSpawn <+> myManageHook <+> manageHook def
                       , workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                       , layoutHook         = myLayoutHook
                       , startupHook        = myStartupHook
                       , modMask            = mod4Mask     -- Rebind Mod to the Windows key
                       , terminal           = term
                       , borderWidth        = 2
                       , normalBorderColor  = "#740054"
                       , focusedBorderColor = "#b6a738"
                       , logHook            = dynamicLogWithPP xmobarPP
                         { ppOutput = hPutStrLn xmproc
                         , ppTitle  = xmobarColor "#ad9200" "" . shorten 50
                         }
                       }
    `additionalKeys` [
        --((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
                       ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
                     , ( (0, xK_Print)
                       , spawn "scrot"
                       )
        -- Launch dmenu for launching applicatiton
--      , ((mod4Mask, xK_p), spawn "exe=`dmenu_run -l 10 -fn 'Migu 1M:size=20'` && exec $exe")
                     , ((mod4Mask, xK_p), shellPrompt myXPConfig)
                     , ( (mod4Mask .|. controlMask, xK_x)
                       , shellPrompt myXPConfig
                       )
                     , ((mod4Mask, xK_Up)   , windows W.focusUp)
                     , ((mod4Mask, xK_Down) , windows W.focusDown)
                     , ((mod4Mask, xK_Left) , prevWS)
                     , ((mod4Mask, xK_Right), nextWS)
                     , ( (mod4Mask .|. shiftMask, xK_Left)
                       , shiftToPrev >> prevWS
                       )
                     , ( (mod4Mask .|. shiftMask, xK_Right)
                       , shiftToNext >> nextWS
                       )
                     , ((mod4Mask .|. shiftMask, xK_Up)  , windows W.swapUp)
                     , ((mod4Mask .|. shiftMask, xK_Down), windows W.swapDown)
                     ]
-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
        --spawnOnce "xsettingsd"
        --spawnOnce "compton --config ~/.compton"
        --spawnOnce  "cd ~/mynotes; and gitit"
        --spawnOn "1" "cd ~/mynotes && gitit && firefox http://localhost:5001"
  spawnOn "7" "urxvt -e alsamixer"
  spawnOn "8" "urxvt -e htop"
  spawnOn "9" "feh -Z https://wiki.haskell.org/wikiupload/b/b8/Xmbindings.png"
        --spawnOnce "feh --bg-fill ~/mynotes/wikidata/dotfiles/resources/desktop.jpg"
        --spawnOnce "patchage"
        --spawnOnce "pactl load-module module-jack-sink channels=2"
        --spawnOnce "pavucontrol"


myLayoutHook =
  onWorkspace "9" (avoidStruts (noBorders Full))
    $   onWorkspace "8" (avoidStruts (noBorders Full))
    $   onWorkspace "7" (avoidStruts (noBorders Full))
    -- $ onWorkspace "3" $ avoidStruts $ simplestFloat
    $   avoidStruts
          ( spacing
            4
            ( gaps [(U, 4), (D, 4), (L, 4), (R, 4)]
                   (ResizableTall 1 (1 / 201) (8 / 13) [(8 / 13), (5 / 13)])
            )
          )
    ||| noBorders Full
    ||| avoidStruts Full

myManageHook = composeAll
  [ className =? "Patchage" --> doShift "5"
  , className =? "Pavucontrol" --> doShift "5"
  , manageDocks
  ]
   -- in a composeAll hook, you'd use: fmap ("VLC" `isInfixOf`)
-- title --> doFloat

myXPConfig :: XPConfig
myXPConfig = def { font              = "xft:M+ 1p:size=16:antialias=true"
                 , fgColor           = "#b6a738"
                 , bgColor           = "#94004c"
                 , borderColor       = "#ffa738"
                 , height            = 50
                 , promptBorderWidth = 1
               --, autoComplete      = Just 100000
                 , bgHLight          = "#f2004c"
                 , fgHLight          = "#b6a738"
                 , position          = Bottom
                 }

