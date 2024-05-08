{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    croc
    progress
    zoxide
    lsof
    libimobiledevice
    ifuse
    adb-sync
  ];

  services.clamav = {
    updater.enable = true;
    daemon.enable = true;
  };

  boot.supportedFilesystems = ["ntfs"];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
