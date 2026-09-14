{ pkgs, env, ... }:

{
  config                 = ./Main.hs;
  enableContribAndExtras = true;
  extraPackages          = x: with x; [ containers xmonad-wallpaper ];
}
