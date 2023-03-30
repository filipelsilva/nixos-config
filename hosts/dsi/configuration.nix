{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../options/graphical.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "dsi";
  };

  hardware = {
  };

  programs = {
  };

  environment.systemPackages = with pkgs; [
  ];

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
