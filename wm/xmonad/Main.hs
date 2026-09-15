module Main where

import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad

myConfig = def
  { focusedBorderColor = "#babbf1"
  , normalBorderColor  = "#303446"
  , modMask            = mod4Mask
  , startupHook        = do
      spawn "feh --bg-fill --randomize ~/Pictures/Wallpapers/*"
      pure ()
  , workspaces
  }
  `additionalKeysP`
  [ ("M-f", spawn "rofi -show drun")
  , ("M-q", spawn "wezterm")
  , ("M-c", kill)
  ]
  `removeKeysP`
  [ "M-S-<Return>"
  , "M-S-c"
  ]
  where
    workspaces = [ "1"
                 , "2"
                 , "3"
                 ]


myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " ★ "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#babbf1" ""
    blue     = xmobarColor "#8caaee" ""
    white    = xmobarColor "#c6d0f5" ""
    yellow   = xmobarColor "#e5c890" ""
    red      = xmobarColor "#e78284" ""
    lowWhite = xmobarColor "#a5adce" ""


main :: IO ()
main = xmonad
  . ewmhFullscreen
  . ewmh
  . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
  $ myConfig
