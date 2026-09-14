{
  inputs = {
    flk.url = "github:numtide/flake-utils";
    qik.url = "github:indypaige/qik";
  };

  outputs        = { flk, qik, ... }:
    flk.lib.eachDefaultSystem (system: {
      packages.default = qik.lib.${system}.haskell.mk {
        tool = pkgs: with pkgs; [
          pkg-config
          xorg.libX11
          xorg.libXrandr
          xorg.libXScrnSaver
          xorg.libXext
        ];

        name = "wm";
        root = ./.;
      };
    });
}
