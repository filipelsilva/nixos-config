# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
	user = "filipe";
	host = "Y540";
	user_complete_name = "Filipe Ligeiro Silva";

	version = "22.05";
in
{
	imports = [
		/etc/nixos/hardware-configuration.nix
	];

	# Bootloader.
	boot.loader.grub = {
		enable = true;
		version = 2;
		device = "/dev/sda";
		useOSProber = true;
	};

	# Enable networking
	networking = {
		networkmanager.enable = true;
		hostName = "${host}";
	};

	programs = {
		dconf.enable = true;
		nm-applet.enable = true;
		zsh.enable = true;
	};

	# Set your time zone.
	time.timeZone = "Europe/Lisbon";

	# Select internationalisation properties.
	i18n = {
		defaultLocale = "en_US.utf8";
		extraLocaleSettings = {
			LC_ADDRESS = "pt_PT.utf8";
			LC_IDENTIFICATION = "pt_PT.utf8";
			LC_MEASUREMENT = "pt_PT.utf8";
			LC_MONETARY = "pt_PT.utf8";
			LC_NAME = "pt_PT.utf8";
			LC_NUMERIC = "pt_PT.utf8";
			LC_PAPER = "pt_PT.utf8";
			LC_TELEPHONE = "pt_PT.utf8";
			LC_TIME = "pt_PT.utf8";
		};
	};

	console = {
		earlySetup = true;
		# FIXME não funciona
		# useXkbConfig = true;
		# font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
	};

	environment = {
		# pathsToLink = [ "/libexec" ];
		variables = {
			TERMINAL = "alacritty";
		};
	};

	sound.enable = true;
	hardware = {
		pulseaudio.enable = true;
		bluetooth.enable = true;
	};
	# FIXME mudar para pipewire

	services = {
		openssh.enable = true; 
		blueman.enable = true;

		xserver = {
			enable = true;
			libinput.enable = true;

			desktopManager.xterm.enable = false;

			displayManager = {
				defaultSession = "none+i3";
			};

			windowManager.i3 = {
				enable = true;
				configFile = "/home/${user}/dotfiles/files/i3config";
				extraPackages = with pkgs; [ # {{{
					rofi
					alacritty
					i3status
					i3lock
					xss-lock
					firefox
					onedrive
					discord
					zoom-us
					ventoy-bin
					auto-cpufreq
					yt-dlp
					ffmpeg
					handbrake
					vlc
					mpv
					transmission-gtk
					tor-browser-bundle-bin
					arandr
					autorandr
					feh
					gthumb
					exiftool
					maim
					pavucontrol
					xdotool
					xclip
					lxappearance
					xdg-user-dirs # FIXME automatizar o comando
					xfce.thunar
					xfce.thunar-archive-plugin
					gnome.file-roller
					okular
					zathura
					redshift
					playerctl
					brightnessctl
					tesseract
					# Ver langs
					# tesseract-data-por
					# tesseract-data-eng
					font-manager
					spotify
					vscode
					lutris
					steam
					slack
					libreoffice
				]; # }}}
			};

			layout = "us";
			xkbVariant = "altgr-intl";
			xkbOptions = "ctrl:swapcaps";
		};
	};

	users.defaultUserShell = pkgs.zsh;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${user} = {
		isNormalUser = true;
		description = "${user_complete_name}";
		extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
		initialPassword = "password";
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	fonts = {
		fontDir.enable = true;
		fonts = with pkgs; [ # {{{
			iosevka
			terminus_font
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
		]; # }}}
	};

	environment.systemPackages = with pkgs; [ # {{{
		home-manager
		linux
		linux-firmware
		binutils
		coreutils
		util-linux
		zsh
		zsh-completions
		nix-zsh-completions
		bash
		bash-completion
		nix-bash-completions
		vim
		neovim
		tmux
		tmuxp
		diffutils
		git
		zoxide
		zip
		unzip
		p7zip
		rar
		atool
		curl
		wget
		netcat
		aria
		nettools
		htop
		btop
		glances
		tree
		python3Full
		#Ver de python mais tarde
		#python-pynvim
		#python-keystone
		#ropper
		#bpython
		pypy
		pypy3
		indent
		gcc
		gdb
		gef
		pwndbg
		rr
		perf-tools
		jdk
		valgrind
		cloc
		tokei
		fzf
		fd
		silver-searcher
		ripgrep
		ripgrep-all
		gping
		duf
		du-dust
		diskus
		neofetch
		onefetch
		pkg-config
		shellcheck
		gnumake
		cmake
		ctags
		entr
		rlwrap
		hexyl
		bat
		hyperfine
		tealdeer
		ascii
		go
		rustup # FIXME ver de automatizar isto
		jq
		nmap
		sysstat
		iftop
		lynx
		bind
		tk
		time
		#words
		asciiquarium
		cht-sh
		vimv
	]; # }}}

	# FIXME rever ssh and stuff; restantes cenas daqui
	# FIXME ver opções de filesystems
	# FIXME ver drivers and stuff
	# FIXME ver overlays, derivations, flakes
	# FIXME adicionar: vagrant virtualbox qemu docker

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#	 enable = true;
	#	 enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system = {
		autoUpgrade.enable = true;
		stateVersion = "${version}"; # Did you read the comment?
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
