import           System.IO
import           Data.List

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
import           XMonad.Util.SpawnOnce
import           XMonad.Actions.SpawnOn
import           XMonad.Hooks.ManageDocks
term = "termite"
editor = "code -r"
browser = "chromium"

devScreen = "DEV"
sysScreen = "SYS"
helpScreen = "HELP"
main = do
  --xmproc <- spawnPipe "xmobar"
  xsetroot <- spawnPipe "xsetroot -cursor_name left_ptr"
  spawn "xrdb -merge .Xresources"
  --spawn "ibus-daemon -rdx"
  --xsettingsd <- spawnPipe "xsettingsd"
  spawn "feh -Z --bg-fill https://raw.githubusercontent.com/NixOS/nixos-artwork/7ece5356398db14b5513392be4b31f8aedbb85a2/gnome/Gnome_Dark.png"
  --compositor <- spawnPipe "compton"
  xmproc   <- spawnPipe "xmobar ~/.xmonad/xmobarrc.hs"
  xmonad
    $                ewmh
    $                docks def
                       { manageHook = manageSpawn <+> myManageHook <+> manageHook def
                       , workspaces = ["1", "2", "3", devScreen, sysScreen, helpScreen]
                       , layoutHook         = myLayoutHook
                       , startupHook        = myStartupHook
                       , modMask            = mod4Mask     -- Rebind Mod to the Windows key
                       , terminal           = term
                       , borderWidth        = 2
                       , normalBorderColor  = "#740054"
                       , focusedBorderColor = "#b6a738"
                       , logHook            = dynamicLogWithPP $ xmobarPP {
                        --ppOutput = hPutStrLn h 
                         ppOrder = \(ws:l:t:_) -> [ws,t,l]
                        , ppOutput = hPutStrLn xmproc
                        , ppTitle  = xmobarColor "#ad9200" "" . shorten 50
                       }

                       }
    `additionalKeys` [
        --((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
                       ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
                       , ( (0, xK_Print), spawn "scrot")
                       , ( (mod4Mask, xK_Return), spawn browser)
                       , ( (mod4Mask, xK_b), spawn browser)
                       , ( (mod4Mask .|. controlMask, xK_Return), spawn editor)
                       , ( (mod4Mask , xK_e), spawn editor)
                     
        -- Launch dmenu for launching applicatiton
--      , ((mod4Mask, xK_p), spawn "exe=`dmenu_run -l 10 -fn 'Migu 1M:size=20'` && exec $exe")
                     , ((mod4Mask, xK_p), shellPrompt myXPConfig)
                     , ( (mod4Mask .|. controlMask, xK_x), shellPrompt myXPConfig)
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

        
  spawnOn devScreen editor
  spawnOn sysScreen "termite -e \"htop -t\""
  spawnOn helpScreen "pqiv -cft ~/test.png"
        --spawnOnce "feh --bg-fill ~/mynotes/wikidata/dotfiles/resources/desktop.jpg"
        --spawnOnce "patchage"
        --spawnOnce "pactl load-module module-jack-sink channels=2"
        --spawnOnce "pavucontrol"


myLayoutHook =
  onWorkspace helpScreen (avoidStruts (noBorders Full))
    $   onWorkspace sysScreen (avoidStruts (noBorders Full))
    $   onWorkspace devScreen (avoidStruts (noBorders Full))
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
myLogHook = dynamicLogWithPP $ xmobarPP {
   --ppOutput = hPutStrLn h 
   ppOrder = \(ws:l:t:_) -> [ws,t,l]
 --  , ppOutput = hPutStrLn xmproc
  -- , ppTitle  = xmobarColor "#ad9200" "" . shorten 50
  }
   

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

