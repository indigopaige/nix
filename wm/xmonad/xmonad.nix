{ pkgs, env, ... }:

{
  config                 = ./Main.hs;
  enableContribAndExtras = true;
}
