{ pkgs, ... }:

{
  package    = pkgs.chromium.override {
    enableWideVine = true;
  };

  extensions = [
			{ id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # darkreader
			{ id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
  ];
}
