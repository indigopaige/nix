module Main where

import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Util.EZConfig
import XMonad

conf = def
  { terminal = "wezterm"
  , modMask  = mod4Mask
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

main :: IO ()
main = xmonad . xmobarProp $ conf
