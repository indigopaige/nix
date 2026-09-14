module Main where

import XMonad.Util.EZConfig
import XMonad

main :: IO ()
main = xmonad $ def
  { terminal = "wezterm"
  , modMask  = mod4Mask
  , workspaces
  }
  `additionalKeysP`
  [ ("M-f", spawn "rofi -show drun")
  , ("M-q", spawn "wezterm")
  ]
  where
    workspaces = [ "1"
                 , "2"
                 , "3"
                 ]
