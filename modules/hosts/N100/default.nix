{ inputs, ... }@top:
{
  flake.modules.nixos.host_N100 =
    { config, pkgs, ... }:
    {
      imports = with top.config.flake.modules.nixos; [
        core_base
        core_nix
        core_locale
        core_location
        core_network
        core_shells
        core_kernel
        core_utils
        core_man
        core_memory
        core_multiplexer
        core_scheduling
        core_tty
        core_nixtools
        core_archive
        hardware_intel
        hardware_firmware
        hardware_power
        hardware_wake-on-lan
        programs_editor
        programs_vcs
        programs_archive
        programs_file
        programs_media
        programs_onedrive
        programs_gpg
        services_monit
        services_wireguard
        services_ssh
        services_fail2ban
        services_onion
        services_jellyfin
        services_servarr
        services_file-server
        services_git-server
        services_ups
        services_ttyd
        services_zfs
        services_nginx
        virtualisation_docker
        virtualisation_libvirt
        virtualisation_vagrant
      ];

      custom.headless = true;
      custom.dataPool = rec {
        name = "data";
        location = "/mnt/${name}";
        drives = [
          "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
          "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
        ];
      };

      custom.domain = "filipelsilva.net";

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
      };

      networking.hostId = "e4245170";

      modules.monitoring = {
        enable = true;
        cpuTempFile = "/sys/class/thermal/thermal_zone1/temp";
        filesystems = [
          "/"
          config.custom.dataPool.location
        ];
        drives = [
          "/dev/disk/by-id/ata-CT500MX500SSD1_2350E889A539"
        ]
        ++ config.custom.dataPool.drives;
        zpools = [ config.custom.dataPool.name ];
      };

      modules.wireguard = {
        enable = true;
        type = "server";
        lastOctet = 1;
        externalInterface = "enp3s0";
      };

      modules.wake-on-lan = {
        enable = true;
        externalInterface = "enp3s0";
      };
    };
}
