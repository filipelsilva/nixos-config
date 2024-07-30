{
  inputs,
  config,
  pkgs,
  headless,
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
    ../../modules/options/archive.nix
    ../../modules/options/editor.nix
    ../../modules/options/fail2ban.nix
    ../../modules/options/file
    ../../modules/options/file-server.nix
    ../../modules/options/firmware.nix
    ../../modules/options/git-server.nix
    ../../modules/options/gpg.nix
    ../../modules/options/intel.nix
    ../../modules/options/kernel.nix
    ../../modules/options/locale.nix
    ../../modules/options/location.nix
    ../../modules/options/man.nix
    ../../modules/options/memory.nix
    (import ../../modules/options/monit.nix monitoringOptions)
    ../../modules/options/monitoring.nix
    ../../modules/options/multiplexer.nix
    ../../modules/options/network.nix
    ../../modules/options/nix.nix
    ../../modules/options/nixtools.nix
    ../../modules/options/onedrive.nix
    ../../modules/options/onion.nix
    ../../modules/options/other.nix
    ../../modules/options/power.nix
    ../../modules/options/programming.nix
    ../../modules/options/scheduling.nix
    ../../modules/options/servarr.nix
    ../../modules/options/shells.nix
    ../../modules/options/ssh.nix
    ../../modules/options/syncthing.nix
    ../../modules/options/terminal.nix
    ../../modules/options/tty.nix
    ../../modules/options/ups.nix
    ../../modules/options/utils.nix
    ../../modules/options/vcs.nix
    ../../modules/options/virtualisation.nix
    ../../modules/options/zfs.nix
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
