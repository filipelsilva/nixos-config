{
  inputs,
  pkgs,
  ...
} @ args: {
  imports = [
    (import ../../modules/options/appimage.nix)
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/bluetooth.nix)
    (import ../../modules/options/browser.nix)
    (import ../../modules/options/communication.nix)
    (import ../../modules/options/editor.nix (args // {headless = false;}))
    (import ../../modules/options/file (args // {headless = false;}))
    (import ../../modules/options/firmware.nix)
    (import ../../modules/options/fonts.nix)
    (import ../../modules/options/gaming)
    (import ../../modules/options/gpg.nix)
    (import ../../modules/options/image.nix (args // {headless = false;}))
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/media.nix (args // {headless = false;}))
    (import ../../modules/options/memory.nix (args // {headless = false;}))
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = false;}))
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/nixtools.nix)
    (import ../../modules/options/nvidia.nix)
    (import ../../modules/options/onedrive.nix)
    (import ../../modules/options/onion.nix (args // {headless = false;}))
    (import ../../modules/options/other.nix)
    (import ../../modules/options/pdf.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/redshift.nix)
    (import ../../modules/options/scheduling.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/terminal.nix)
    (import ../../modules/options/tty.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
    (import ../../modules/options/virtualisation.nix)
    (import ../../modules/options/wine.nix)
    (import ../../modules/options/word.nix)
    (import ../../modules/options/xserver)
    ../../modules/users/filipe.nix
    ./hardware-configuration.nix
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
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  networking.hostName = "Y540";

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
