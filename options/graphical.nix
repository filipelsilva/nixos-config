{ config, pkgs, ... }:
{
	imports = [
		./common.nix
		../packages/desktop.nix
	];

	environment = {
		variables = {
			TERMINAL = "alacritty";
		};
	};

	sound.enable = true;

	location.provider = "geoclue2";

	hardware = {
		pulseaudio.enable = true;
		bluetooth.enable = true;
	};

	programs = {
		dconf.enable = true;
		nm-applet.enable = true;
		xss-lock = {
			enable = true;
			lockerCommand = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
		};
		thunar = {
			enable = true;
			plugins = with pkgs.xfce; [
				thunar-archive-plugin
				thunar-volman
				tumbler
			];
		};
	};


	services = {
		blueman.enable = true;

		redshift = {
			enable = true;
			temperature = {
				day = 6500;
				night = 4500;
			};
		};

		xserver = {
			enable = true;

			libinput = {
				enable = true;

				mouse = {
					accelProfile = "flat";
					accelSpeed = "-1";
					horizontalScrolling = true;
					naturalScrolling = false;
				};

				touchpad = {
					accelProfile = "flat";
					accelSpeed = "-1";
					horizontalScrolling = true;
					naturalScrolling = true;
					scrollMethod = "twofinger";
					tapping = true;
				};
			};

			desktopManager = {
				wallpaper = {
					combineScreens = false;
					mode = "fill";
				};
			};

			displayManager = {
				defaultSession = "none+i3";
				# startx.enable = true; # TODO deploy with this line
			};

			windowManager.i3 = {
				enable = true;
				extraPackages = with pkgs; [
					i3
					i3status
					i3lock-fancy
					xss-lock
					rofi
				];
			};
		};
	};

	fonts = {
		fontDir.enable = true;
		fonts = with pkgs; [
			font-manager
			iosevka
			terminus_font
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			corefonts # Microsoft fonts
		];
		# TODO add custom font
		# fontconfig.localConf = builtins.readFile "/home/${user}/dotfiles/desktop/fontconfig/.config/fontconfig/fonts.conf";
	};
}
