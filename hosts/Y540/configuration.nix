{ config, pkgs, ... }:
{
	imports = [
		../../options/graphical.nix
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
		hostName = "Y540";
	};

	hardware = {
		opengl.driSupport32Bit = true;
	};

	programs = {
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
		};
	};

	environment.systemPackages = with pkgs; [
		discord
		steam
		lutris
		heroic
	];

	nixpkgs.overlays = let
		discordOverlay = self: super: {
			discord = super.discord.override {
				withOpenASAR = true;
			};
		};
	in [ discordOverlay ];

	services = {
		xserver = {
			xkbOptions = "ctrl:swapcaps";
		};
	};
}
