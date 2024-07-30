{
  inputs,
  config,
  pkgs,
  headless,
  ...
} @ args: {
  imports = [
    ../../modules/options/appimage.nix
    ../../modules/options/archive.nix
    ../../modules/options/bluetooth.nix
    ../../modules/options/browser.nix
    ../../modules/options/communication.nix
    ../../modules/options/editor.nix
    ../../modules/options/file
    ../../modules/options/fingerprint.nix
    ../../modules/options/firmware.nix
    ../../modules/options/fonts.nix
    ../../modules/options/gaming
    ../../modules/options/gpg.nix
    ../../modules/options/image.nix
    ../../modules/options/intel.nix
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/location.nix
    ../../modules/options/man.nix
    ../../modules/options/media.nix
    ../../modules/options/memory.nix
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    ../../modules/options/network.nix
    ../../modules/options/nix.nix
    ../../modules/options/nixtools.nix
    ../../modules/options/onedrive.nix
    ../../modules/options/onion.nix
    ../../modules/options/other.nix
    ../../modules/options/pdf.nix
    ../../modules/options/power.nix
    ../../modules/options/programming.nix
    ../../modules/options/scheduling.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/terminal.nix
    ../../modules/options/tty.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
    ../../modules/options/virtualisation.nix
    ../../modules/options/wine.nix
    ../../modules/options/word.nix
    ../../modules/options/xserver
    ../../modules/users/filipe.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/home-manager/users";
    extraSpecialArgs = {
      inherit inputs;
      nixosConfig = config;
      headless = headless;
    };
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  networking.hostName = "T490";

  services = {
    xserver = {
      xkb.options = "ctrl:swapcaps";
    };
    autorandr = {
      enable = true;
    };
  };
}
