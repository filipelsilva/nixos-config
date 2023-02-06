{ config, pkgs, ... }:
{
	imports = [
		../common.nix
		./hardware-configuration.nix
	];

	boot.loader.grub = {
		enable = true;
		version = 2;
		device = "/dev/sda";
		useOSProber = true;
	};

	networking = {
		networkmanager.enable = true;
		hostName = "dsi";
	};

	sound.enable = true;
	hardware = {
		opengl.driSupport32Bit = true;
	};

	programs = {};

	services = {
		xserver = {
			layout = "us";
			xkbVariant = "altgr-intl";
			xkbOptions = "ctrl:swapcaps";
		};
		openssh = {
			enable = true;
			passwordAuthentication = false;
			kbdInteractiveAuthentication = false;
			permitRootLogin = "no";
		};
	};

}
