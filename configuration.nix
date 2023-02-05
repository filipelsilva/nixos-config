# Edit this configuration file to define what should be installed on
# your system.	Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
	user = "filipe";
	host = "Y540";
	user_complete_name = "Filipe Ligeiro Silva";

	version = "22.11";
	unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
	imports = [
		/etc/nixos/hardware-configuration.nix
	];

	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			unstable = import unstableTarball {
				config = config.nixpkgs.config;
			};
		};
	};

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		loader.grub = {
			enable = true;
			version = 2;
			device = "/dev/sda";
			useOSProber = true;
		};
	};

	networking = {
		networkmanager.enable = true;
		hostName = "${host}";
	};

	programs = {
		dconf.enable = true;
		nm-applet.enable = true;
		zsh = {
			enable = true;
			setOptions = [];
		};
	};

	time.timeZone = "Europe/Lisbon";

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
		# FIXME não funciona
		# useXkbConfig = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
	};

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
				extraPackages = with pkgs; [ # {{{
					# Display management
					arandr
					autorandr
					brightnessctl
					redshift
					xdotool	# X11 automation tool

					# Window manager
					i3
					i3status
					i3lock
					xss-lock
					rofi

					# Terminal emulator
					alacritty

					# Browser
					firefox
					chromium
					tor-browser-bundle-bin

					# Video/Audio management
					vlc
					mpv
					clementine
					yt-dlp
					flac
					sox
					ffmpeg
					handbrake
					kid3
					playerctl
					obs-studio
					spotify
					streamlink  # Pipe streams into a video player
					pavucontrol # Control audio sources/sinks

					# Torrent management
					transmission
					transmission-gtk

					# Image management
					sxiv
					feh
					gthumb
					exiftool
					imagemagick
					gimp
					krita
					inkscape
					mediainfo
					maim     # Screenshot utility
					guvcview # Camera

					# Theme management
					arc-theme
					lxappearance

					# File management
					xdg-user-dirs
					xfce.thunar
					xfce.thunar-archive-plugin
					xfce.thunar-volman
					xfce.tumbler
					gnome.file-roller            # Archive manager for thunar
					gvfs                         # Enables things like trashing files in Thunar
					ntfs3g                       # Support for NTFS drives
					lxde.lxsession               # This includes lxpolkit, in order to be able to mount some drives
					perl536Packages.FileMimeInfo # Detect MIME type of files

					# PDF management
					pandoc
					pdftk
					libsForQt5.okular
					zathura
					ocamlPackages.cpdf
					diff-pdf

					# OCR
					tesseract

					# Clipboard management
					xclip
					xsel

					# Other packages
					discord
					texlive.combined.scheme-full
					libreoffice-still
					tigervnc        # VNC server/client
					remmina         # Remote desktop client
					barrier         # KVM
					bless           # Hex editor
					gpick           # Color picker
					mypaint         # Drawing table
					scrcpy          # Android screen mirroring and control
					vscode
					onedrive        # OneDrive client
					ventoy-bin-full # Make multiboot USB drives
					xdragon         # Drag-and-drop source/sink
					spek            # Audio inspector
					# openasar # Make Discord faster TODO
					]; # }}}
			};

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

	users.users.${user} = {
		isNormalUser = true;
		initialPassword = "${user}";
		shell = pkgs.zsh;
		description = "${user_complete_name}";
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

	environment.systemPackages = with pkgs; [ # {{{
		# Linux kernel, base packages
		linux
		linux-firmware
		util-linux

		# Man pages and info
		man
		man-pages
		texinfo

		# Other basic utilities
		binutils
		coreutils
		diffutils
		findutils
		iputils
		moreutils
		pciutils

		# Find filenames quickly
		mlocate

		# Calculators
		bc
		libqalculate
		qalculate-qt

		# Shells and respective completions
		bash
		bash-completion
		nix-bash-completions
		zsh
		zsh-completions
		nix-zsh-completions

		# Dotfile manager
		stow

		# Text editors
		ed
		gnused
		sd
		vimHugeX
		neovim

		# Pagers
		less
		lesspipe

		# Terminal multiplexer
		screen
		tmux
		tmuxp # automatically create tmux session with layouts
		tmate # share tmux session

		# VCS
		git
		git-filter-repo
		tk   # gitk dependency
		gh   # github cli
		glab # gitlab cli

		# File management
		rsync
		progress

		# Archive management
		atool
		gzip
		zip
		unzip
		p7zip
		fastjar

		# Memory management
		duf
		du-dust
		diskus
		ncdu
		dua
		fdupes

		# Network stuff
		curl
		wget
		aria
		lynx
		socat
		netcat-openbsd
		nmap
		traceroute
		tcpdump
		bind

		# System monitoring
		procps
		procs
		htop
		bottom
		sysstat
		iftop
		nethogs
		bandwhich
		nvtop

		# Python and related packages (some of them used for gdb/gef/pwndbg)
		python3Full
		python310Packages.pip
		pypy
		pypy3
		black
		pwntools
		python310Packages.pyperclip
		python310Packages.pynvim
		keystone
		capstone
		sage

		# C/Cpp and related packages
		gcc
		gdb
		gef
		pwndbg
		indent
		valgrind
		ctags

		# Java
		jdk

		# Go
		go

		# Lua
		lua

		# Rust
		rustup

		# Ruby
		ruby

		# JavaScript
		nodejs

		# Perl
		perl

		# JSON
		jq
		jc

		# Shell script static analysis
		shellcheck

		# Auto builder
		gnumake
		cmake

		# Code counter
		cloc
		tokei

		# Profile and benchmark programs
		time
		hyperfine
		strace
		ltrace
		perf-tools
		cargo-flamegraph

		# Finders
		fzf
		fd
		silver-searcher
		pdfgrep
		ripgrep
		ripgrep-all

		# Information fetchers
		neofetch
		onefetch

		# Other packages
		pup                   # Like jq, but for HTML (parsing)
		ctop                  # Top for containers
		parallel              # Xargs alternative
		entr                  # Run commands when files change
		gping                 # Ping, but with a graph
		rlwrap                # Readline wrapper
		bat                   # Cat with syntax highlighting
		hexyl                 # Hex viewer
		tealdeer              # Cheat sheet for common programs
		ascii                 # Show character codes
		haskellPackages.words # Populate /usr/share/dict with list of words
		datamash              # Manipulate data in textual format
		lnav                  # Logfile Navigator
		zoxide                # Autojump to recent folders
		tree                  # List files in tree format
		pipe-rename           # Rename files in your $EDITOR
		rename                # Rename files using Perl regex
		magic-wormhole        # Send/Receive files
		openssh               # SSH programs

		# Virtualisation
		# docker
		# docker-compose
		# libvirt
		# virt-manager
		# virtualbox
		# vagrant
	]; # }}}

	#virtualisation = {
	#	docker = {
	#		enable = true;
	#		rootless = {
	#			enable = true;
	#			setSocketVariable = true;
	#		};
	#	};
	#	libvirtd = {
	#		enable = true;
	#	};
	#	virtualbox = {
	#		host = {
	#			enable = true;
	#			enableExtensionPack = false;
	#		};
	#		guest = {
	#			enable = true;
	#			x11 = true;
	#		};
	#	};
	#};

	system = {
		autoUpgrade.enable = true;
		stateVersion = "${version}";
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
