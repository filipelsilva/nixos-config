{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    magic-wormhole
    progress
    zoxide
    lsof
    libimobiledevice
    ifuse
    adb-sync
  ];

  boot.supportedFilesystems = ["ntfs"];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
