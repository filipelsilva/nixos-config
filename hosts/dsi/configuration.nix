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

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking = {
    networkmanager.enable = true;
    hostName = "dsi";
  };

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
