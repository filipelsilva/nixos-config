{...}: {
  imports = [
    ../../modules/user.nix
    ../../modules/wireguard.nix
    ../../profiles/archive.nix
    ../../profiles/audio.nix
    ../../profiles/bluetooth.nix
    ../../profiles/browser.nix
    ../../profiles/communication.nix
    ../../profiles/darkman.nix
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
    ../../profiles/package-managers.nix
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
    ../../profiles/virtualisation/docker.nix
    ../../profiles/virtualisation/libvirt.nix
    ../../profiles/virtualisation/vagrant.nix
    ../../profiles/virtualisation/virtualbox.nix
    ../../profiles/wayland.nix
    ../../profiles/wine.nix
    ../../profiles/word.nix
    ./hardware-configuration.nix
  ];

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

  modules.wireguard = {
    enable = true;
    type = "client";
    lastOctet = 3;
  };

  environment.etc."sway/config.d/keyboard.conf".text = ''
    input "*" xkb_options ctrl:swapcaps
  '';
}
