{ pkgs, inputs, config, ... }:
{
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
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
    postman
    tt
    okta-aws-cli
    catppuccin-cursors.mochaMaroon
    python3Packages.pylatexenc
    texlive.combined.scheme-full
    hyprlandPlugins.hyprtrails
    hyprlandPlugins.hyprexpo
    hyprlandPlugins.hyprwinwrap
    satty
    ffmpeg
    ffmpegthumbnailer
    unar
    poppler
    neofetch
    youtube-music
    libxkbcommon
    libressl
    elinks
    tree-sitter-cli
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
    # ".config/nvim/templates/norg" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/tui/nixvim/lua/norg-templates";
    #   recursive = true;
    # };
    ".config/BetterDiscord/themes/translucence-plus.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/discord/blur-theme.css";
    };
    ".librewolf/afnctw1x.default/chrome" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/librewolf/colorful-minimalist";
      recursive = true;
    };
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

    ".config/yazi/flavors/tokyo-night.yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/tui/yazi/tokyo-night.yazi";
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox-nightly";
    XDG_BROWSER = "firefox-nightly";
    MANGAL_READER_READ_IN_BROWSER = "true";
    MANGAL_READER_BROWSER = "firefox-nightly";
    OKTA_AWSCLI_ORG_DOMAIN = "enagonathletics.okta.com";
    OKTA_AWSCLI_OIDC_CLIENT_ID = "0oa1qmrpslvkm9M9w1d8";
    OKTA_AWSCLI_OPEN_BROWSER = "true";
    OKTA_AWSCLI_FORMAT = "aws-credentials";
    OKTA_AWSCLI_WRITE_AWS_CREDENTIALS = "true";
    OKTA_AWSCLI_CACHE_ACCESS_TOKEN = "false";
    OKTA_AWSCLI_SESSION_DURATION = 3600;
    HYPRCURSOR_THEME = "catppuccin-cursors.mochaMaroon";
    HYPRCURSOR_SIZE = 24;
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
    userName = "TLSingh1";
    userEmail = "tai8910@gmail.com";
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
