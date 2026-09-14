{ pkgs, env, ... }:

{
  config                 = ./xmonad.hs;
  enableContribAndExtras = true;
}
