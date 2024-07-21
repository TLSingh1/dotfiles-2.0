{ pkgs, inputs, config, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./main-user.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # this was a test to get them in sops secrets in nix config
  # altho this is only from system config and not home-managr
  systemd.services."sometestservice" = {
    script = ''
      echo "
        This is a test of a secret using sops-nix
        $(cat ${config.sops.secrets.test.path})

        and here are the git secrets
        $(cat ${config.sops.secrets.git-username.path})
        $(cat ${config.sops.secrets.git-email.path})
        " > /var/lib/sometestservice/testfile
      '';
    serviceConfig = {
      User = "sometestservice";
      WorkingDirectory = "/var/lib/sometestservice";
    };
  };
  users.users.sometestservice = {
    home = "/var/lib/sometestservice";
    createHome = true;
    isSystemUser = true;
    group = "sometestservice";
  };
  users.groups.sometestservice = { };

  # Secrets
  # sops.defaultSopsFile = ../../secrets/secrets.yaml;
  # sops.defaultSopsFormat = "yaml";
  # sops.age.keyFile = "/home/tai/.config/sops/age/keys.txt";
  # sops.secrets.example-key = { };
  # sops.secrets."myservice/my_subdir/my_secret" = { };

  # sops.secrets = {
  #   test-key = { };
  #   git-username.owner = config.users.users.tai.name;
  #   git-email.owner = config.users.users.tai.name;
  # };


  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-dark";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tai = {
    isNormalUser = true;
    description = "tai";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    # packages = with pkgs; [
    # #  thunderbird
    # ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "tai" = import ./home.nix;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # one day ill figure out how to make this work
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    discord
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wev
    nerdfonts
    luajit
    polkit-kde-agent
    cliphist
    libgcc
    libgccjit
    gcc_multi
    luajitPackages.jsregexp
    luajitPackages.lua-utils-nvim
    ripgrep
    wl-clipboard-rs
    nodejs_22
    zip
    unzip
    rustup
    supergfxctl
    cmake
    gnumake
    sops
    meson
    wget
    jq
    lshw
    sddm
    nix-prefetch-git
    neon-town-sddm
    sddm-sugar-dark
    libsForQt5.qt5.qtgraphicaleffects
    minikube
    # sddm-astronaut
    # (pkgs.callPackage ../../packages/neon-town-sddm.nix {})
  ];

  # NOTE: NVIDIA
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  hardware.nvidia-container-toolkit.enable = true;

  # virtualisation.containers.cdi.dynamic.nvidia.enable = true;


  # List services that you want to enable:
  services.supergfxd.enable = true;
  services.asusd.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes"];

}
