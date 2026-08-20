# NixOS Config

## Notes

### Installing using nixos-install

1. Create the following structure on the disk:

```
sda           8:0    1 114,6G  0 disk 
├─sda1        8:1    1     2G  0 part 
└─sda2        8:2    1 112,6G  0 part
```

2. Commands:

```bash
# format the boot partition
mkfs.fat -F 32 /dev/sda1 -n "NixOS-Boot"
# create an encrypted partition
cryptsetup luksFormat -y --label="NixOS-Encrypted" /dev/sda2
# open the encrypted partition and map it to /dev/mapper/cryptroot
cryptsetup luksOpen /dev/sda2 cryptroot
# create the physical volume
pvcreate /dev/mapper/cryptroot
# create a volume group inside
vgcreate lvmroot /dev/mapper/cryptroot
# create the swap volume
lvcreate --size 8G lvmroot --name swap
# if you desire, create a home volume
lvcreate --size 150G lvmroot --name home
# create the root volume
lvcreate -l 100%FREE lvmroot --name root
# format as usual for root partition
mkfs.ext4 -L "NixOS-Root" /dev/mapper/lvmroot-root
# if you previously made the home partition, do it too
mkfs.ext4 -L "NixOS-Home" /dev/mapper/lvmroot-home
# format the swap partition
mkswap -L "NixOS-Swap" /dev/mapper/lvmroot-swap
# mount root
mount /dev/disk/by-label/NixOS-Root /mnt
# mount boot
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# again, if you did the home volume
mkdir /mnt/home
mount /dev/disk/by-label/NixOS-Home /mnt/home
# turn on swap
swapon /dev/disk/by-label/NixOS-Swap
```

Layout should look like:

```
sda                disk
├─sda1             part  /mnt/boot
└─sda2             part
  └─cryptroot      crypt
    ├─lvmroot-swap lvm   [SWAP]
    └─lvmroot-root lvm   /mnt
```

3. Run `sudo nixos-generate-config --root /mnt` and modify
`hardware-configuration.nix` to include the following:

```nix
{
  # cut
  # We need to add "cryptd" as one of our kernel modules, or else the system
  # won't be booted expecting an encrypted partition, which is where our root,
  # swap, (and home) logical volumes resides in.
  boot.initrd.kernelModules = [
    "dm-snapshot"
    "cryptd"
  ];

  fileSystems."/" =
    # Modify this to the name of the root logical volume (used in mkfs.ext4)
    {
      device = "/dev/disk/by-label/NixOS-Root";
      fsType = "ext4";
    };

  # If you also did the home logical volume
  fileSystems."/home" = {
    device = "/dev/disk/by-label/NixOS-Home";
    fsType = "ext4";
  };

  # Modify this to the name of the encrypted partition (cryptsetup luksFormat)
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NixOS-Encrypted";

  # Modify this to the name of the unencrypted boot partition (used in mkfs.fat)
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NixOS-Boot";
    fsType = "vfat";
  };
  # Modify this to the name of the swap logical volume (used in mkswap)
  swapDevices = [ { device = "/dev/disk/by-label/NixOS-Swap"; } ];
}
```

4. Commands to install from this config:

```bash
sudo nixos-install --impure --flake .#<config>
```

5. After boot from new filesystem, to mark boot partition as EFI System
Partition (ESP), run the following command:

```bash
sudo sgdisk --typecode=1:ef00 /dev/nvme0n1
```

Links:
* https://nixos.wiki/wiki/Full_Disk_Encryption#Set_Up_Full_Disk_Encryption_with_Swap_Volume_and_Unencrypted_Boot
* https://gist.github.com/mrcjkb/84072b3819cfdd82ce0ffc5ffd06342e
* https://nixos.wiki/wiki/NixOS_Installation_Guide#Install_NixOS

### Entering the system with nixos-enter (assuming NixOS Live USB):

```bash
sudo cryptsetup luksOpen /dev/sda2 volume
sudo mount /dev/mapper/volume-root /mnt
sudo mount /dev/sda1 /mnt/boot
sudo mount /dev/mapper/volume-home /mnt/home # if you have home partition
sudo nixos-enter
```

To exit this:

```bash
sudo umount /mnt/home # if you have home partition
sudo umount /mnt/boot
sudo umount /mnt
sudo cryptsetup luksClose volume
```

### To reinstall the bootloader (from inside system):

````bash
NIXOS_INSTALL_BOOTLOADER=1 /run/current-system/bin/switch-to-configuration boot
````

### Switching from systemd-boot to GRUB:

Links:
* https://www.reddit.com/r/NixOS/comments/1hxqfy7/whats_the_proper_way_to_switch_from_systemdboot/
* https://discourse.nixos.org/t/systemd-boot-keeps-starting-even-if-grub-is-installed/23065/13
* https://discourse.nixos.org/t/change-bootloader-to-grub/49947

TLDR:
1. `boot.loader.efi.canTouchEfiVariables = false;`
2. `boot.loader.grub.efiInstallAsRemovable = true;`
3. `rm -rf /boot/*`
4. `nixos-rebuild switch --install-bootloader`
