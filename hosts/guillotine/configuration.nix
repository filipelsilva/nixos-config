{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    ../../modules/options/archive.nix
    ../../modules/options/boot.nix
    ../../modules/options/console.nix
    (
      import ../../modules/options/editor (
        args // {headless = false;}
      )
    )
    ../../modules/options/file.nix
    (
      import ../../modules/options/fonts (
        args // {headless = false;}
      )
    )
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/man.nix
    ../../modules/options/memory.nix
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    (
      import ../../modules/options/network.nix (
        args // {headless = false;}
      )
    )
    ../../modules/options/nix.nix
    ../../modules/options/other.nix
    ../../modules/options/programming.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
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
    device = "/dev/sda";
  };

  networking.hostName = "guillotine";
}
