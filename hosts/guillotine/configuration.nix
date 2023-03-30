{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../options/common.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = true;
    };
  };

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "guillotine";
  };

  hardware = {
  };

  programs = {
  };

  environment.systemPackages = with pkgs; [];

  services = {
  };
}
