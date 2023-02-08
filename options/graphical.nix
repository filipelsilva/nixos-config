{ config, pkgs, ... }:
{
	imports = [
		../packages/desktop.nix
	];

	environment = {
		variables = {
			TERMINAL = "alacritty";
		};
	};

	sound.enable = true;
	hardware = {
		pulseaudio.enable = true;
		bluetooth.enable = true;
	};

	programs = {
		dconf.enable = true;
		nm-applet.enable = true;
	};

	services = {
		blueman.enable = true;

		xserver = {
			enable = true;
			libinput.enable = true;

			desktopManager.xterm.enable = false;

			displayManager = {
				defaultSession = "none+i3";
				# startx.enable = true; # TODO deploy with this line
			};

			windowManager.i3 = {
				enable = true;
				extraPackages = with pkgs; [
					i3
					i3status
					i3lock
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
