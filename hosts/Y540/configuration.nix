{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/user.nix
    ../../modules/wireguard/server.nix
    ../../profiles/appimage.nix
    ../../profiles/archive.nix
    ../../profiles/bluetooth.nix
    ../../profiles/browser.nix
    ../../profiles/communication.nix
    ../../profiles/darkman.nix
    ../../profiles/editor.nix
    ../../profiles/fail2ban.nix
    ../../profiles/file
    ../../profiles/firmware.nix
    ../../profiles/fonts.nix
    ../../profiles/gaming
    ../../profiles/gpg.nix
    ../../profiles/image.nix
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
    ../../profiles/nvidia.nix
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
    ../../profiles/virtualisation/docker.nix
    ../../profiles/virtualisation/libvirt.nix
    ../../profiles/virtualisation/vagrant.nix
    ../../profiles/virtualisation/virtualbox.nix
    ../../profiles/wine.nix
    ../../profiles/word.nix
    ../../profiles/xserver
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  modules.wireguard-server = {
    enable = true;
    lastOctet = 2;
    externalInterface = "enp7s0";
  };

  # For Windows's clock and NixOS' to work together
  time.hardwareClockInLocalTime = true;

  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  services.udev = {
    enable = true;
    packages = [pkgs.autorandr];
    extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';
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
