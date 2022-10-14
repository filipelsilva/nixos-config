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
				configFile = "/home/${user}/dotfiles/desktop/i3/.config/i3/config";
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
					rhythmbox
					yt-dlp
					flac
					sox
					ffmpeg
					handbrake
					kid3
					playerctl
					streamlink  # Pipe streams into a video player
					pavucontrol # Control audio sources/sinks

					# Torrent management
					transmission
					transmission-gtk

					# Image management
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
					xfce.thunar-volman
					xfce.thunar-archive-plugin
					gnome.file-roller # Archive manager for thunar
					gvfs              # Enables things like trashing files in Thunar
					ntfs3g            # Support for NTFS drives
					lxde.lxsession    # This includes lxpolkit, in order to be able to mount some drives

					# PDF management
					pandoc
					pdftk
					zathura

					# OCR
					tesseract

					# Clipboard management
					xclip
					xsel

					# Other packages
					discord
					libreoffice-still
					bless         # Hex editor
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
			font-manager
			iosevka
			terminus_font
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
		]; # }}}
	};

	environment.systemPackages = with pkgs; [ # {{{
		# home-manager

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
		pciutils

		# Find filenames quickly
		mlocate

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
		vim
		neovim

		# Terminal multiplexer
		screen
		tmux
		tmuxp # automatically create tmux session with layouts

		# VCS
		git
		tk # gitk dependency

		# Archive management
		atool
		gzip
		zip
		unzip
		p7zip
		fastjar

		# Network stuff
		curl
		wget
		aria
		lynx
		socat
		nmap
		traceroute
		tcpdump
		bind

		# System monitoring
		htop
		sysstat
		iftop

		# Python and related packages (some of them used for gdb/gef/pwndbg)
		python3Full
		pypy
		pypy3
		# Ver python

		# C/Cpp and related packages
		gcc
		gdb
		pwndbg
		indent
		valgrind
		ctags

		# Java
		jdk

		# Go
		go

		# Rust
		rustup

		# Ruby
		ruby

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
		perf-tools
		cargo-flamegraph

		# Finders
		fzf
		fd
		silver-searcher
		ripgrep
		ripgrep-all

		# Memory management
		duf
		du-dust
		diskus

		# Information fetchers
		neofetch
		onefetch

		# Other packages
		parallel       # Xargs alternative
		entr           # Run commands when files change
		rlwrap         # Readline wrapper
		bat            # Cat with syntax highlighting
		hexyl          # Hex viewer
		tealdeer       # Cheat sheet for common programs
		ascii          # Show character codes
		datamash       # Manipulate data in textual format
		lnav           # Logfile Navigator
		zoxide         # Autojump to recent folders
		tree           # List files in tree format
		pipe-rename    # Rename files in your $EDITOR
		rename         # Rename files using Perl regex
		magic-wormhole # Send/Receive files
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
