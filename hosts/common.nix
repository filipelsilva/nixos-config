{ config, pkgs, ... }:
{
	imports = [
		../packages/headless.nix
		../packages/desktop.nix
	];

	users.users.filipe = {
		isNormalUser = true;
		initialPassword = "password";
		shell = pkgs.zsh;
		description = "Filipe Ligeiro Silva";
		extraGroups = [
			"audio"
			"docker"
			"libvirtd"
			"networkmanager"
			"storage"
			"vboxusers"
			"video"
			"wheel"
		];
	};

	time.timeZone = "Europe/Lisbon"; # TODO use timesync

	i18n = {
		defaultLocale = "en_US.utf8";
		extraLocaleSettings = {
			LC_MEASUREMENT = "pt_PT.utf8";
			LC_MONETARY = "pt_PT.utf8";
			LC_PAPER = "pt_PT.utf8";
		};
	};

	console = {
		earlySetup = true;
		# TODO não funciona
		# useXkbConfig = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
	};

	system = {
		autoUpgrade.enable = true;
		stateVersion = "22.11";
	};

	nixpkgs.config.allowUnfree = true;

	environment = {
		pathsToLink = [ "/libexec" ];
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
		zsh = {
			enable = true;
			setOptions = [];
		};
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

	nixpkgs.overlays = let
		myOverlay = self: super: {
			discord = super.discord.override { withOpenASAR = true; };
		};
	in [ myOverlay ];

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

	virtualisation = {
		docker = {
			enable = true;
			rootless = {
				enable = true;
				setSocketVariable = true;
			};
		};
		libvirtd = {
			enable = true;
		};
		virtualbox = {
			host = {
				enable = true;
				enableExtensionPack = false;
			};
			guest = {
				enable = true;
				x11 = true;
			};
		};
	};

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
		settings.auto-optimise-store = true;
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 7d";
		};
	};
}
