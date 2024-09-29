{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    croc
    progress
    pv
    zoxide
    lsof
    libimobiledevice
    ifuse
    adb-sync
  ];

  programs.adb.enable = true;

  services = {
    clamav = {
      updater.enable = true;
      daemon.enable = true;
    };
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };

  userConfig.extraGroups = [
    "adbusers"
    "storage"
  ];

  boot.supportedFilesystems = ["ntfs"];
}
