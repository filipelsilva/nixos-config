{
  config,
  pkgs,
  ...
}: {
  networking.hostId = "e4245170";

  boot = {
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
    openseachest
  ];

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

    smartd = {
      enable = true;
      extraOptions = [
        "--interval=43200"
      ];
    };
  };
}
