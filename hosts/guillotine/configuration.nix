{ config, pkgs, ... }:
{
	imports = [
		../../options/common.nix
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
		hostName = "guillotine";
	};

	hardware = {
	};

	programs = {
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
	};

	environment.systemPackages = with pkgs; [];

	services = {
	};
}
