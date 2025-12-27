{dataPool, ...}: {
  imports = [
    ../../modules/monit.nix
    ../../modules/user.nix
    ../../modules/wake-on-lan.nix
    ../../modules/wireguard.nix
    ../../profiles/archive.nix
    ../../profiles/darkman.nix
    ../../profiles/editor.nix
    ../../profiles/fail2ban.nix
    ../../profiles/file
    ../../profiles/file-server.nix
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
  };

  networking.hostId = "e4245170";

  modules.monitoring = {
    enable = true;
    cpuTempFile = "/sys/class/thermal/thermal_zone1/temp";
    filesystems = ["/" dataPool.location];
    drives =
      [
        "/dev/disk/by-id/ata-CT500MX500SSD1_2350E889A539"
      ]
      ++ dataPool.drives;
    zpools = [dataPool.name];
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
}
