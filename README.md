# Notes

## Switching from systemd-boot to GRUB:

Links:
* https://www.reddit.com/r/NixOS/comments/1hxqfy7/whats_the_proper_way_to_switch_from_systemdboot/
* https://discourse.nixos.org/t/systemd-boot-keeps-starting-even-if-grub-is-installed/23065/13
* https://discourse.nixos.org/t/change-bootloader-to-grub/49947

TLDR:
1. boot.loader.efi.canTouchEfiVariables = false;
2. boot.loader.grub.efiInstallAsRemovable = true;
3. rm -rf /boot/*
4. nixos-rebuild switch --install-bootloader
