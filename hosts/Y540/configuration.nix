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
		myOverlay = self: super: {
			discord = super.discord.override { withOpenASAR = true; };
		};
	in [ myOverlay ];

	services = {
		xserver = {
			layout = "us";
			xkbVariant = "altgr-intl";
			xkbOptions = "ctrl:swapcaps";
		};
		openssh = {
			enable = false;
			passwordAuthentication = false;
			kbdInteractiveAuthentication = false;
			permitRootLogin = "no";
		};
	};
}
