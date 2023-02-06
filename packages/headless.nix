{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
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
		# zsh-forgit            # Git aliases with fzf # TODO make it work
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

		# NixOS Home Manager
		home-manager

		# Virtualisation
		docker
		docker-compose
		libvirt
		virt-manager
		virtualbox
		vagrant

		# Gaming
		steam
		lutris
		heroic
	];
}