module Main where

import XMonad.Util.EZConfig
import XMonad

main :: IO ()
main = xmonad $ def
  { terminal = "wezterm"
  , modMask  = mod4Mask
  , workspaces
  }
  `remapKeysP`
  [ ("M-S-<Return>", "M-q")
  ]
  `additionalKeysP`
  [ ("M-f", spawn "dmenu")
  ]
  where
    workspaces = [ "1"
                 , "2"
                 , "3"
                 ]
