{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../options/graphical.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      # device = "/dev/nvme0n1";
      device = "nodev";
      useOSProber = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "Y540";
  };

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
