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
    impatient-mode
    org-superstar
    haskell-mode
    org-contrib
    ledger-mode
    inheritenv
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
