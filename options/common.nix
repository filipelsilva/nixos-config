{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../packages/headless.nix
  ];

  boot = {
    loader.grub.useOSProber = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users.filipe = {
    isNormalUser = true;
    initialPassword = "password";
    shell = pkgs.zsh;
    description = "Filipe Ligeiro Silva";
    extraGroups = [
      "audio"
      "docker"
      "libvirtd"
      "networkmanager"
      "storage"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  time.timeZone = "Europe/Lisbon";

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "pt_PT.utf8";
      LC_MONETARY = "pt_PT.utf8";
      LC_PAPER = "pt_PT.utf8";
    };
  };

  console = {
    # earlySetup = true;
    # useXkbConfig = true; # TODO não funciona
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
    keyMap = "us";
  };

  environment = {
    pathsToLink = ["/libexec"];
  };

  programs = {
    zsh = {
      enable = true;
      setOptions = [];
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        passwordAuthentication = false;
        kbdInteractiveAuthentication = false;
        permitRootLogin = "no";
      };
      hostKeys = [
        {
          comment = "host key";
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
    };
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true; # TODO deploy com true
      };
      # guest = {
      # 	enable = true;
      # 	x11 = true;
      # };
    };
  };

  system = {
    stateVersion = "22.11";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
