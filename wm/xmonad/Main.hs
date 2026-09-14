module Main where

import XMonad

main :: IO ()
main = xmonad $ def
  { terminal = "wezterm"
  }
