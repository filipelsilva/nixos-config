{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
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

    boot = {
      supportedFilesystems = {
        ntfs = true;
        exfat = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    file
    croc
    progress
    pv
    zoxide
    lsof
  ] ++ lib.lists.optionals isLinux [
    libimobiledevice
    ifuse
    adb-sync
    android-tools
  ];
}
