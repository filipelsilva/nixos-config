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
    ../../modules/options/fail2ban.nix
    ../../modules/options/file
    ../../modules/options/firmware.nix
    ../../modules/options/fonts.nix
    ../../modules/options/gaming
    ../../modules/options/gpg.nix
    ../../modules/options/image.nix
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
    ../../modules/options/nvidia.nix
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
    users = import "${inputs.self}/home-manager/users";
  };

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
