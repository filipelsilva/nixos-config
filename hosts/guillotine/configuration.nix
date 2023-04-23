{
  config,
  pkgs,
  inputs,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    ../../modules/options/archive.nix
    ../../modules/options/console.nix
    (
      import ../../modules/options/editor (
        args // {headless = true;}
      )
    )
    (
      import ../../modules/options/file (
        args // {headless = true;}
      )
    )
    (
      import ../../modules/options/fonts (
        args // {headless = true;}
      )
    )
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/man.nix
    (
      import ../../modules/options/memory.nix (
        args // {headless = true;}
      )
    )
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    (
      import ../../modules/options/network.nix (
        args // {headless = true;}
      )
    )
    ../../modules/options/nix.nix
    ../../modules/options/other.nix
    ../../modules/options/power.nix
    ../../modules/options/programming.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/home-manager/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = true;
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking.hostName = "guillotine";
}
