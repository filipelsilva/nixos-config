{
  config,
  pkgs,
  inputs,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    ../../modules/options/alacritty.nix
    ../../modules/options/archive.nix
    ../../modules/options/audio.nix
    ../../modules/options/bluetooth.nix
    ../../modules/options/browser.nix
    ../../modules/options/communication.nix
    ../../modules/options/console.nix
    ../../modules/options/devenv.nix
    (
      import ../../modules/options/editor (
        args // {headless = false;}
      )
    )
    (
      import ../../modules/options/file (
        args // {headless = false;}
      )
    )
    (
      import ../../modules/options/fonts (
        args // {headless = false;}
      )
    )
    ../../modules/options/gaming
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/man.nix
    ../../modules/options/media.nix
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
    ../../modules/options/nvidia.nix
    ../../modules/options/onedrive.nix
    ../../modules/options/other.nix
    ../../modules/options/pdf.nix
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
    users = import "${inputs.self}/home-manager/users";
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
      useOSProber = true;
      device = "nodev";
    };
  };

  networking.hostName = "Y540";

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
