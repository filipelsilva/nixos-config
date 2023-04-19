{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    ../../modules/options/alacritty.nix
    ../../modules/options/archive.nix
    ../../modules/options/audio.nix
    ../../modules/options/browser.nix
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
    (
      import ../../modules/options/memory.nix (
        args // {headless = false;}
      )
    )
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    (
      import ../../modules/options/network.nix (
        args // {headless = false;}
      )
    )
    ../../modules/options/nix.nix
    ../../modules/options/pdf.nix
    ../../modules/options/polkit.nix
    ../../modules/options/power.nix
    ../../modules/options/programming.nix
    ../../modules/options/redshift.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
    ../../modules/options/virtualisation.nix
    ../../modules/options/word.nix
    ../../modules/options/xserver
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

  networking.hostName = "dsi";

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
