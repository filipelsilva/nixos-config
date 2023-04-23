{
  config,
  pkgs,
  inputs,
  ...
} @ args: {
  imports = [
    (import ./hardware-configuration.nix)
    (import ../../modules/users/filipe.nix)
    (import ../../modules/options/alacritty.nix)
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/audio.nix)
    (import ../../modules/options/bluetooth.nix)
    (import ../../modules/options/browser.nix)
    (import ../../modules/options/communication.nix)
    (import ../../modules/options/console.nix)
    (import ../../modules/options/devenv.nix)
    (import ../../modules/options/editor (args // {headless = false;}))
    (import ../../modules/options/file (args // {headless = false;}))
    (import ../../modules/options/fonts (args // {headless = false;}))
    (import ../../modules/options/gaming)
    (import ../../modules/options/image.nix)
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/memory.nix (args // {headless = false;}))
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = false;}))
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/nvidia.nix)
    (import ../../modules/options/onedrive.nix)
    (import ../../modules/options/other.nix)
    (import ../../modules/options/pdf.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/redshift.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/torrent.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
    (import ../../modules/options/video.nix)
    (import ../../modules/options/virtualisation.nix)
    (import ../../modules/options/word.nix)
    (import ../../modules/options/xserver)
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
