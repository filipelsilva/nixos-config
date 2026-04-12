{
  config,
  pkgs,
  lib,
  ...
}:
let
  bliss = pkgs.fetchurl {
    url = "https://archive.org/download/bliss-600dpi/bliss-600dpi.png";
    sha256 = "a72d44ee40c406a1b8837a94e7fc8834bd7f6f22e8c5da9aa28da9d5922d47da";
  };
in
{
  flake.modules.nixos.desktop_wayland =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      nixosConfig = config;
      sway_command = if config.networking.hostName == "Y540" then "sway --unsupported" else "sway";
    in
    {
      programs = {
        dconf.enable = true;
        sway = {
          enable = true;
          wrapperFeatures.gtk = true;
          xwayland.enable = true;
          extraSessionCommands = ''
            ${pkgs.batsignal}/bin/batsignal -b
          '';

          extraPackages = with pkgs; [
            i3status
            rofi

            swayidle
            swaylock

            wlr-randr
            wdisplays
            shikane

            sway-contrib.grimshot

            dunst
            libnotify

            wl-clipboard

            batsignal

            brightnessctl

            glib
            gnome-themes-extra
            adwaita-icon-theme
            adwaita-icon-theme-legacy
            lxappearance
            libsForQt5.qt5ct

            dragon-drop
            tigervnc
            remmina
            scrcpy
            uxplay
            piper
          ];
        };
      };

      security.polkit.enable = true;

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        enable = true;
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

      services = {
        gnome.gnome-keyring.enable = true;
        ratbagd.enable = true;
        greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format '%A, %d %B %Y - %H:%M:%S' --cmd '${sway_command}'";
              user = "greeter";
            };
          };
        };
        logind.settings.Login = {
          HandlePowerKey = "suspend";
          HandleLidSwitch = "suspend";
        };
      };

      environment.etc."sway/config.d/extra.conf".text = ''
        # Start tray icons
        exec ${lib.optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &"}
        exec ${lib.optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}

        # Notifications
        exec ${pkgs.dunst}/bin/dunst &

        # Monitor configuration
        exec ${pkgs.shikane}/bin/shikane &

        # https://github.com/swaywm/sway/wiki#gtk-applications-take-20-seconds-to-start
        exec ${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME
        exec ${pkgs.dbus}/bin/dbus-update-activation-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME

        # Set theme and icons
        exec ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
        exec ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"

        # Wallpaper
        output * background ${bliss} fill
      '';

      userConfig.extraGroups = [ "video" ];

      homeConfig =
        { config, ... }:
        {
          home.file = {
            ".config/sway".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/sway/.config/sway";
            ".config/i3status".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
            ".config/dunst".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/dunst/.config/dunst";
          };

          services.gammastep = {
            enable = true;
            provider = "manual";
            latitude = nixosConfig.location.latitude;
            longitude = nixosConfig.location.longitude;
          };
        };
    };
}
