{
  inputs,
  pkgs,
  config,
  ...
} @ args: {
  imports = [
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/editor.nix (args // {headless = true;}))
    (import ../../modules/options/fail2ban.nix)
    (import ../../modules/options/file (args // {headless = true;}))
    (import ../../modules/options/firmware.nix)
    (import ../../modules/options/gpg.nix)
    (import ../../modules/options/intel.nix)
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/memory.nix (args // {headless = true;}))
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = true;}))
    (import ../../modules/options/nextcloud.nix)
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/nixtools.nix)
    (import ../../modules/options/onedrive.nix)
    (import ../../modules/options/onion.nix (args // {headless = true;}))
    (import ../../modules/options/other.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/scheduling.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/terminal.nix)
    (import ../../modules/options/tty.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
    (import ../../modules/options/virtualisation.nix)
    ../../modules/users/filipe.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/home-manager/users";
    extraSpecialArgs = {
      inherit inputs;
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

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = ["zfs"];
    zfs = {
      extraPools = ["data"];
      forceImportRoot = false;
      forceImportAll = false;
    };
  };

  environment.systemPackages = with pkgs; [
    hdparm
    hddtemp
    smartmontools
    zfstools
  ];

  networking = {
    hostName = "N100";
    hostId = "e4245170";
  };

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -B 254 -S 241 /dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2
    ${pkgs.hdparm}/sbin/hdparm -B 254 -S 241 /dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R
  '';

  hardware.sensor = {
    hddtemp = {
      enable = true;
      drives = [
        "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
        "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
      ];
    };
  };

  services = {
    zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
      trim = {
        enable = true;
        interval = "weekly";
      };
    };

    sanoid = {
      enable = true;
      interval = "daily";
      datasets."data" = {
        autosnap = true;
        autoprune = true;
        hourly = 0;
        daily = 0;
        weekly = 1;
        monthly = 1;
        yearly = 1;
      };
    };

    netdata.enable = true;
  };
}
