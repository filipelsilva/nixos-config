{
  inputs,
  config,
  pkgs,
  headless,
  ...
} @ args: {
  imports = [
    ../../modules/users/filipe.nix
    ../../profiles/appimage.nix
    ../../profiles/archive.nix
    ../../profiles/bluetooth.nix
    ../../profiles/browser.nix
    ../../profiles/communication.nix
    ../../profiles/editor.nix
    ../../profiles/file
    ../../profiles/fingerprint.nix
    ../../profiles/firmware.nix
    ../../profiles/fonts.nix
    ../../profiles/gaming
    ../../profiles/gpg.nix
    ../../profiles/image.nix
    ../../profiles/intel.nix
    ../../profiles/kernel.nix
    ../../profiles/locale.nix
    ../../profiles/location.nix
    ../../profiles/man.nix
    ../../profiles/media.nix
    ../../profiles/memory.nix
    ../../profiles/multiplexer.nix
    ../../profiles/network.nix
    ../../profiles/nix.nix
    ../../profiles/nixtools.nix
    ../../profiles/onedrive.nix
    ../../profiles/onion.nix
    ../../profiles/other.nix
    ../../profiles/pdf.nix
    ../../profiles/power.nix
    ../../profiles/programming.nix
    ../../profiles/scheduling.nix
    ../../profiles/shells.nix
    ../../profiles/ssh.nix
    ../../profiles/terminal.nix
    ../../profiles/tty.nix
    ../../profiles/utils.nix
    ../../profiles/vcs.nix
    ../../profiles/virtualisation.nix
    ../../profiles/wine.nix
    ../../profiles/word.nix
    ../../profiles/xserver
    ./hardware-configuration.nix
  ];

  home-manager = {
    users = import "${inputs.self}/home-manager/users";
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

  services = {
    xserver = {
      xkb.options = "ctrl:swapcaps";
    };
    autorandr = {
      enable = true;
    };
  };
}
