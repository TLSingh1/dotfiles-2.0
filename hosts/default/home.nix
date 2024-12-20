{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
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
    # ytermusic
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
    lua-language-server
    nil
    nixd
    stylua
    alejandra
    typescript
    nodePackages.svelte-language-server
    tailwindcss-language-server
    vscode-langservers-extracted
    inputs.zen-browser.packages."${system}".default
    obsidian
    nodePackages.prettier
    prettierd
    mermaid-cli
    zoom-us
    slack
    terraform
    # tfswitch
    terraform-ls
    okta-aws-cli
    broot
    awscli2
    steam
    zed-editor
    pyright
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
    # ".mozilla/firefox/default/user.js" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/user.js";
    # };
    ".mozilla/firefox/default/chrome/theme" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/theme";
      recursive = true;
    };
    ".mozilla/firefox/default/chrome/userChrome.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/userChrome.css";
    };
    ".mozilla/firefox/default/chrome/userContent.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/firefox/FF-ULTIMA/userContent.css";
    };
    ".zen/bszeqo1i.Default (alpha)/chrome/userContent.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tai/.dotfiles/modules/home-manager/gui/zen/userContent.css";
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
