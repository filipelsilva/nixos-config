{ lib, ... }:
{
  flake.modules.nixos.programs_file =
    { config, pkgs, ... }:
    let
      inherit (config.custom) headless;
    in
    {
      environment.systemPackages =
        with pkgs;
        [
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
        ]
        ++ lib.lists.optionals (!headless) [
          nautilus
          file-roller
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
        gvfs.enable = lib.mkIf (!headless) true;
        tumbler.enable = lib.mkIf (!headless) true;
        croc.enable = lib.mkIf (!headless) true;
      };

      programs.nautilus-open-any-terminal = lib.mkIf (!headless) {
        enable = true;
        terminal = "alacritty";
      };

      xdg = lib.mkIf (!headless) {
        mime = {
          enable = true;
          defaultApplications = {
            "application/pdf" = "org.pwmt.zathura.desktop";
            "inode/directory" = "nautilus.desktop";
          };
        };
      };

      home-manager.users.${config.custom.user} = lib.mkIf (!headless) {
        xdg = {
          enable = true;
          userDirs = {
            enable = true;
            createDirectories = true;
          };
        };
      };

      users.users.${config.custom.user}.extraGroups = [
        "adbusers"
        "storage"
      ];

      boot.supportedFilesystems = {
        ntfs = true;
        exfat = true;
      };
    };
}
