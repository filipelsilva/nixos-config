{
  config,
  pkgs,
  lib,
  ...
}: let
  bliss = pkgs.fetchurl {
    url = "https://archive.org/download/bliss-600dpi/bliss-600dpi.png";
    sha256 = "a72d44ee40c406a1b8837a94e7fc8834bd7f6f22e8c5da9aa28da9d5922d47da";
  };
  blissNew = pkgs.fetchurl {
    url = "https://msdesign.blob.core.windows.net/wallpapers/Microsoft_Nostalgic_Windows_Wallpaper_4k.jpg";
    sha256 = "8f9a38bfc0f5670eb8d92e92539719c1086abee4313930f4ad1fd1e7ad6d305e";
  };
in {
  services = {
    displayManager.defaultSession = "none+i3";

    redshift.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          combineScreens = false;
          mode = "fill";
        };
      };

      displayManager.lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };

      windowManager.i3 = {
        enable = true;
        extraSessionCommands = ''
          ${pkgs.xorg.xrdb}/bin/xrdb -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset}/bin/xset -b s off -dpms
          ${pkgs.feh}/bin/feh --bg-fill ~/.background-image
          ${pkgs.lxsession}/bin/lxpolkit &
          ${pkgs.xsettingsd}/bin/xsettingsd &
          ${pkgs.batsignal}/bin/batsignal -b
          ${lib.optionalString config.services.xserver.displayManager.lightdm.enable "${pkgs.lightlocker}/bin/light-locker &"}
          ${lib.optionalString config.services.autorandr.enable "${pkgs.autorandr}/bin/autorandr --change --skip-options crtc"}
          ${lib.optionalString config.programs.thunar.enable "${pkgs.xfce.thunar}/bin/thunar --daemon &"}
          ${lib.optionalString config.networking.networkmanager.enable "${pkgs.networkmanagerapplet}/bin/nm-applet &"}
          ${lib.optionalString config.hardware.bluetooth.enable "${pkgs.blueman}/bin/blueman-applet &"}
        '';
        extraPackages = with pkgs; [
          i3status
          rofi
          libnotify
          dunst
          xsettingsd
          xorg.xev
          xorg.xmodmap
          batsignal
        ];
      };
    };

    # don’t shutdown when power button is short-pressed
    logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandleLidSwitch = "suspend";
    };
  };

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.lightlocker}/bin/light-locker-command --lock";
    };
  };

  userConfig.extraGroups = ["video"];

  homeConfig = {config, ...}: {
    home.file = {
      ".xinitrc".text = ''exec i3'';
      ".background-image".source = blissNew;
      ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3";
      ".config/i3status".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/i3/.config/i3status";
      ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/dunst/.config/dunst";
      ".Xresources".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/xresources/.Xresources";
    };
  };
}
