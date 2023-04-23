{
  config,
  pkgs,
  inputs,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/console.nix)
    (import ../../modules/options/editor (args // {headless = true;}))
    (import ../../modules/options/file (args // {headless = true;}))
    (import ../../modules/options/fonts (args // {headless = true;}))
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/memory.nix (args // {headless = true;}))
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = true;}))
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/other.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
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
