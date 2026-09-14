{ pkgs, env, ... }@inputs: let f = { enable = true; };
                               i = x: (import x inputs) // f;
in {
  programs.home-manager.enable                 = true;

  home.stateVersion                            = "26.05";

  home.homeDirectory                           = "/home/" + env.user;
  home.username                                = env.user;

  home.pointerCursor                           = i ./home/cursor.nix;

  home.shell                                   = {
    enableBashIntegration = true;
  };

  imports                                      = [
    env.inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin                                   = {
    accent     = "lavender";
    flavor     = "frappe";

    autoEnable = true;

    enable     = true;

    hyprland   = {
      enable = false;
    };
  };

  home.packages                                = with pkgs; [
    nerd-fonts.iosevka
    pavucontrol
    alsa-utils
    overskride
    iosevka
    ripgrep
    nmgui
    unzip
    slurp
    nemo
    grim
    bash
    vlc
  ];

  wayland.windowManager                        = {
    hyprland = i ./wm/hyprland.nix;
  };

  gtk                                          = i ./home/gtk.nix;

  services                                     = {
    hyprpolkitagent = i ./services/hyprpolkitagent.nix;
    hyprlauncher    = i ./services/hyprlauncher.nix;
    mpdscribble     = i ./services/mpdscribble.nix;
    hyprpaper       = i ./services/hyprpaper.nix;
    blanket         = i ./services/blanket.nix;
    emacs           = i ./services/emacs.nix;
    mpd             = i ./services/mpd.nix;
  };

  programs                                     = {
    thunderbird = i ./programs/thunderbird.nix;
    quickshell  = i ./programs/quickshell.nix;
    chromium    = i ./programs/chromium.nix;
    starship    = i ./programs/starship.nix;
    hyprlock    = i ./programs/hyprlock.nix;
    vesktop     = i ./programs/vesktop.nix;
    wezterm     = i ./programs/wezterm/wezterm.nix;
    direnv      = i ./programs/direnv.nix;
    emacs       = i ./programs/emacs/emacs.nix;
    eza         = i ./programs/eza.nix;
    ssh         = i ./programs/ssh.nix;
    git         = i ./programs/git.nix;
  };

  home.file.".config/hypr/hyprtoolkit.conf"    = {
    enable = true;

    text   = ''
    font_family_monospace = Iosevka
    accent_secondary      = 0xFF98EAD4
    rounding_large        = 0
    rounding_small        = 0
    font_family           = Iosevka
    background            = 0xFF000000
    accent                = 0xFF655162
    '';
  };

  home.file."side-update.sh"                   = {
    enable     = true;
    executable = true;

    text       = ''
    #!/bin/sh
    nix flake update nix --flake /etc/nixos
    nixos-rebuild switch
    '';
  };

  home.file."full-update.sh"                   = {
    enable     = true;

    executable = true;

    text       = ''
    #!/bin/sh
    nix flake update --flake /etc/nixos
    nixos-rebuild switch
    '';
  };

  xdg.configFile."shell"                       = {
    source = pkgs.lib.getExe pkgs.bash;
  };
}
