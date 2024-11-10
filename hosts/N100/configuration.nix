{user, ...}: {
  imports = [
    ../../modules/file-server.nix
    ../../modules/monit.nix
    ../../modules/user.nix
    ../../modules/wake-on-lan.nix
    ../../modules/wireguard.nix
    ../../profiles/archive.nix
    ../../profiles/darkman.nix
    ../../profiles/editor.nix
    ../../profiles/fail2ban.nix
    ../../profiles/file
    ../../profiles/firmware.nix
    ../../profiles/git-server.nix
    ../../profiles/gpg.nix
    ../../profiles/intel.nix
    ../../profiles/jellyfin.nix
    ../../profiles/kernel.nix
    ../../profiles/locale.nix
    ../../profiles/location.nix
    ../../profiles/man.nix
    ../../profiles/media.nix
    ../../profiles/memory.nix
    ../../profiles/multiplexer.nix
    ../../profiles/network.nix
    ../../profiles/nginx.nix
    ../../profiles/nix.nix
    ../../profiles/nixtools.nix
    ../../profiles/onedrive.nix
    ../../profiles/onion.nix
    ../../profiles/other.nix
    ../../profiles/power.nix
    ../../profiles/scheduling.nix
    ../../profiles/servarr.nix
    ../../profiles/shells.nix
    ../../profiles/ssh.nix
    ../../profiles/syncthing.nix
    ../../profiles/terminal.nix
    ../../profiles/tty.nix
    ../../profiles/ups.nix
    ../../profiles/utils.nix
    ../../profiles/vcs.nix
    ../../profiles/virtualisation/docker.nix
    ../../profiles/virtualisation/libvirt.nix
    ../../profiles/virtualisation/vagrant.nix
    ../../profiles/virtualisation/virtualbox.nix
    ../../profiles/zfs.nix
    ./hardware-configuration.nix
  ];

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
    kernelParams = [
      # "pci=realloc"
      # "pci=nocrs"
      "pci=realloc,nocrs"
    ];
  };

  networking.hostId = "e4245170";

  modules.monitoring = {
    enable = true;
    cpuTempFile = "/sys/class/thermal/thermal_zone1/temp";
    filesystems = ["/" "/mnt/data"];
    drives = [
      "/dev/disk/by-id/ata-CT500MX500SSD1_2350E889A539"
      "/dev/disk/by-id/ata-ST8000VN004-3CP101_WRQ01QF2"
      "/dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ3T73R"
    ];
    zpools = [
      "data"
    ];
  };

  modules.file-server.enable = true;

  modules.wireguard = {
    enable = true;
    type = "server";
    lastOctet = 1;
    externalInterface = "enp2s0";
  };

  modules.wake-on-lan = {
    enable = true;
    externalInterface = "enp2s0";
  };
}
