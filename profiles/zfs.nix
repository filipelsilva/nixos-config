{
  lib,
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
    supportedFilesystems = ["zfs"];
    zfs = {
      # TODO remove (and see this https://docs.oracle.com/cd/E19120-01/open.solaris/817-2271/gbaln/index.html)
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

  # TODO remove and check that monit still gets the temps
  hardware.sensor = {
    hddtemp = {
      enable = true;
      drives = [
        "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
        "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
      ];
    };
  };

  # TODO generalize
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
