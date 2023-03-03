{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		# Display management
		arandr
		autorandr
		brightnessctl
		redshift
		xdotool	# X11 automation tool

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
		spek        # Audio inspector

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
		gpick    # Color picker
		mypaint  # Drawing table

		# Theme management
		arc-theme
		lxappearance

		# File management
		xdg-user-dirs
		xfce.thunar
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
		texlive.combined.scheme-full
		libreoffice-still
		qalculate-qt
		zoom-us
		(vscode-with-extensions.override {
			vscode = vscodium;
			vscodeExtensions = with vscode-extensions; [
				vscodevim.vim
			];
		})
		font-manager
		tigervnc        # VNC server/client
		remmina         # Remote desktop client
		barrier         # KVM
		bless           # Hex editor
		scrcpy          # Android screen mirroring and control
		uxplay          # AirPlay server
		onedrive        # OneDrive client
		ventoy-bin-full # Make multiboot USB drives
		xdragon         # Drag-and-drop source/sink
	];

	fonts.fonts = with pkgs; [
		iosevka-bin
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		corefonts # Microsoft fonts
	];
}
