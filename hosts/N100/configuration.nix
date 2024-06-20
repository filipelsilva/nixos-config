{
  inputs,
  config,
  pkgs,
  ...
} @ args: let
  monitoringOptions = {
    filesystems = ["/" "/mnt/data"];
    drives = [
      "/dev/disk/by-id/ata-CT500MX500SSD1_2350E889A539"
      "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
      "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
    ];
    zpools = [
      "data"
    ];
    allowIps = [];
    openPort = true;
  };
in {
  imports = [
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/editor.nix (args // {headless = true;}))
    (import ../../modules/options/fail2ban.nix)
    (import ../../modules/options/file (args // {headless = true;}))
    (import ../../modules/options/firmware.nix)
    (import ../../modules/options/git-server.nix)
    (import ../../modules/options/gpg.nix)
    (import ../../modules/options/intel.nix)
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/location.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/memory.nix (args // {headless = true;}))
    (import ../../modules/options/monit.nix monitoringOptions)
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = true;}))
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/nixtools.nix)
    (import ../../modules/options/onedrive.nix)
    (import ../../modules/options/onion.nix (args // {headless = true;}))
    (import ../../modules/options/other.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/scheduling.nix)
    (import ../../modules/options/servarr.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/syncthing.nix)
    (import ../../modules/options/terminal.nix)
    (import ../../modules/options/tty.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
    (import ../../modules/options/virtualisation.nix)
    (import ../../modules/options/zfs.nix)
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
      headless = true;
    };
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = false;
        device = "nodev";
      };
    };
  };

  networking.hostName = "N100";
}
