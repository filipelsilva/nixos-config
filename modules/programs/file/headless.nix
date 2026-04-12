{ pkgs, ... }:
{
  flake.modules.nixos.programs_file-headless =
    { pkgs, ... }:
    {
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
        android-tools
      ];

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

      boot.supportedFilesystems = {
        ntfs = true;
        exfat = true;
      };
    };
}
