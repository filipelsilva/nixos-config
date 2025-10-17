{
  config,
  pkgs,
  lib,
  ...
}: let
  nixosConfig = config;

  bliss = pkgs.fetchurl {
    url = "https://archive.org/download/bliss-600dpi/bliss-600dpi.png";
    sha256 = "a72d44ee40c406a1b8837a94e7fc8834bd7f6f22e8c5da9aa28da9d5922d47da";
  };
  blissNew = pkgs.fetchurl {
    url = "https://msdesign.blob.core.windows.net/wallpapers/Microsoft_Nostalgic_Windows_Wallpaper_4k.jpg";
    sha256 = "8f9a38bfc0f5670eb8d92e92539719c1086abee4313930f4ad1fd1e7ad6d305e";
  };
in {
  programs = {
    dconf.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
      extraSessionCommands = ''
        ${lib.optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
        ${lib.optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
        ${lib.optionalString config.programs.thunar.enable "${pkgs.xfce.thunar}/bin/thunar --daemon &"}
        ${pkgs.batsignal}/bin/batsignal -b
      '';
      # ${lib.optionalString config.services.autorandr.enable "${pkgs.autorandr}/bin/autorandr --change --skip-options crtc"}

      extraPackages = with pkgs; [
        i3status
        rofi

        swayidle
        swaylock

        wlr-randr
        wdisplays
        kanshi

        sway-contrib.grimshot

        dunst
        libnotify

        wl-clipboard

        batsignal # Battery status

        brightnessctl

        # Theme management
        gnome-themes-extra
        adwaita-icon-theme
        adwaita-icon-theme-legacy
        lxappearance
        libsForQt5.qt5ct

        xdragon # Drag-and-drop source/sink
        tigervnc # VNC server/client
        remmina # Remote desktop client
        scrcpy # Android screen mirroring and control
        uxplay # AirPlay server
        piper # Gaming mouse configuration
      ];
    };
  };

  security.polkit.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    ratbagd.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
    logind.settings.Login = {
      # don’t shutdown when power button is short-pressed
      HandlePowerKey = "suspend";
      HandleLidSwitch = "suspend";
    };
  };

  environment.etc."sway/config.d/theme.conf".text = ''
    exec gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
    exec gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"
    output * background ${bliss} fill
  '';

  userConfig.extraGroups = ["video"];

  homeConfig = {config, ...}: {
    home.file = {
      ".config/i3status".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
      ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/dunst/.config/dunst";
    };

    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = nixosConfig.location.latitude;
      longitude = nixosConfig.location.longitude;
    };
  };
}
