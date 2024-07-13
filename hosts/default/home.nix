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
    ytermusic
    cbonsai
    pipes
    asciiquarium-transparent
    tdf
    mangal
    hyprlandPlugins.hyprtrails
    hyprlandPlugins.hyprexpo
    hyprlandPlugins.hyprwinwrap

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

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox-nightly";
    XDG_BROWSER = "firefox-nightly";
    MANGAL_READER_READ_IN_BROWSER = "true";
    MANGAL_READER_BROWSER = "firefox-nightly";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox-nightly.desktop";
      "x-scheme-handler/http" = "firefox-nightly.desktop";
      "x-scheme-handler/https" = "firefox-nightly.desktop";
      "x-scheme-handler/about" = "firefox-nightly.desktop";
      "x-scheme-handler/unknown" = "firefox-nightly.desktop";

      "application/xhtml+xml" = "firefox-nightly.desktop";
      "application/x-extension-htm" = "firefox-nightly.desktop";
      "application/x-extension-html" = "firefox-nightly.desktop";
      "application/x-extension-shtml" = "firefox-nightly.desktop";
      "application/x-extension-xhtml" = "firefox-nightly.desktop";
      "application/x-extension-xht" = "firefox-nightly.desktop";
      "x-scheme-handler/ftp" = "firefox-nightly.desktop";
      "x-scheme-handler/chrome" = "firefox-nightly.desktop";
      "application/x-www-browser" = "firefox-nightly.desktop";
      "application/json" = "firefox-nightly.desktop";
    };
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
