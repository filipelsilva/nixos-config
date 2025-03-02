{
  lib,
  pkgs,
  dataPool,
  ...
}: {
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;
    supportedFilesystems = ["zfs"];
    zfs = {
      # TODO remove (and see this https://docs.oracle.com/cd/E19120-01/open.solaris/817-2271/gbaln/index.html)
      extraPools = [dataPool.name];
      forceImportRoot = false;
      forceImportAll = false;
    };
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    zfstools
    openseachest
  ];

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
      datasets.${dataPool.name} = {
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
