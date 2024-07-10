{ pkgs, inputs, config, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.ags.homeManagerModules.default
    ../../modules/home-manager/wm
    ../../modules/home-manager/tui
    ../../modules/home-manager/gui
  ];

  home.username = "tai";
  home.homeDirectory = "/home/tai";

  # WARN: Never change this
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    htop
    btop
    brave
    discord
    dunst
    _1password-gui
    eza
    telegram-desktop
    luajitPackages.lua-utils-nvim
    bun
    dart-sass
    fd
    brightnessctl
    swww
    matugen
    fzf
    # hyprpicker
    slurp
    wf-recorder
    wayshot
    swappy
    asusctl
    librewolf
    zoxide
    grim
    imagemagick
    zenity
    gnome-themes-extra
    gtk-engine-murrine
    xfce.thunar
    wl-color-picker
    betterdiscordctl
    macchina
    google-chrome
    pavucontrol
    luajitPackages.jsregexp
    wlsunset
    inputs.hyprpicker.packages.${pkgs.system}.default
    nwg-look
    qalculate-gtk
    obs-studio
    xwaylandvideobridge
    kdePackages.kdeconnect-kde
    bat
    yarn
    prismlauncher
    caprine-bin
    jdk17
    mupdf
    mpv
    ripgrep
    hyprlandPlugins.hyprtrails
    hyprlandPlugins.hyprexpo
  ];

  home.file = {
    ".config/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/wm/ags";
      recursive = true;
    };
    ".config/macchina" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/tui/macchina";
      recursive = true;
    };
    ".config/BetterDiscord/themes/translucence-plus.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/discord/blur-theme.css";
    };
    ".librewolf/afnctw1x.default/chrome" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/librewolf/colorful-minimalist";
      recursive = true;
    };
    # ".librewolf/afnctw1x.default/chrome/userChrome.css" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/librewolf/userChrome.css";
    # };
    # ".mozilla/firefox/pus15frm.default/chrome/userChrome.css" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/userChrome.css";
    # };

    ".mozilla/firefox/pus15frm.default/chrome/theme" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/theme";
      recursive = true;
    };
    ".mozilla/firefox/pus15frm.default/chrome/userChrome.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/userChrome.css";
    };
    ".mozilla/firefox/pus15frm.default/chrome/userContent.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/userContent.css";
    };

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;  
    # NOTE: this is where i would like to use secrets
    userName = "TLSingh1";
    userEmail = "tai8910@gmail.com";
  };

  programs.neovim = {
    enable = false;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme-transparent;
      name = "Materia-dark-compact";
    };
  };

  qt = {
    enable = true;
  };

  # WARN: let home manager install/manage itself
  programs.home-manager = {
    enable = true;
  };
}
