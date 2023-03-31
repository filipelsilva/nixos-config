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
    ../../modules/options/bluetooth.nix
    ../../modules/options/boot.nix
    ../../modules/options/browser.nix
    ../../modules/options/communication.nix
    ../../modules/options/console.nix
    ../../modules/options/editor
    {headless = false;}
    ../../modules/options/file.nix
    ../../modules/options/fonts
    {headless = false;}
    ../../modules/options/gaming
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/man.nix
    ../../modules/options/media.nix
    ../../modules/options/memory.nix
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    ../../modules/options/network.nix
    {headless = false;}
    ../../modules/options/nix.nix
    ../../modules/options/onedrive.nix
    ../../modules/options/other.nix
    ../../modules/options/pdf.nix
    ../../modules/options/polkit.nix
    ../../modules/options/programming.nix
    ../../modules/options/redshift.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
    ../../modules/options/virtualisation.nix
    ../../modules/options/word.nix
    ../../modules/options/xserver.nix
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

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      # device = "/dev/nvme0n1";
      device = "nodev";
    };
  };

  networking.hostname = "Y540";

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
  };
}
