{ ... }:

let extraConfig = builtins.readFile ./init.el;
in {
  inherit extraConfig;

  extraPackages = epkgs: with epkgs; [
    rainbow-identifiers
    gruber-darker-theme
    rainbow-delimiters
    multiple-cursors
    org-super-agenda
    catppuccin-theme
    org-superstar
    haskell-mode
    org-contrib
    inheritenv
    org-caldav
    rust-mode
    org-recur
    qml-mode
    poly-org
    lua-mode
    nix-mode
    ligature
    polymode
    org-roam
    tuareg
    envrc
    magit
    dash
    smex
  ];
}
