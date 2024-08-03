{...}: {
  imports = [
    ../../modules/monit.nix
    ../../modules/user.nix
    ../../profiles/archive.nix
    ../../profiles/editor.nix
    ../../profiles/fail2ban.nix
    ../../profiles/file
    ../../profiles/file-server.nix
    ../../profiles/firmware.nix
    ../../profiles/git-server.nix
    ../../profiles/gpg.nix
    ../../profiles/home-manager
    ../../profiles/intel.nix
    ../../profiles/kernel.nix
    ../../profiles/locale.nix
    ../../profiles/location.nix
    ../../profiles/man.nix
    ../../profiles/memory.nix
    ../../profiles/multiplexer.nix
    ../../profiles/network.nix
    ../../profiles/nix.nix
    ../../profiles/nixtools.nix
    ../../profiles/onedrive.nix
    ../../profiles/onion.nix
    ../../profiles/other.nix
    ../../profiles/power.nix
    ../../profiles/programming.nix
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
  };

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
    allowedIps = [];
    openPort = true;
  };

  networking.hostId = "e4245170";
}
