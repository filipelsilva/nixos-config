{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [darkman xdg-desktop-portal-gtk];
  };

  services = {
    dbus.packages = with pkgs; [darkman gcr];

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "altgr-intl";

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          combineScreens = false;
          mode = "fill";
        };
      };

      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          enable = true;
          greeters.slick.enable = true;
        };
      };

      xautolock = {
        enable = true;
        extraOptions = [
          "-corners ----"
          "-detectsleep"
        ];
        time = 5;
        nowlocker = "${pkgs.lightlocker}/bin/light-locker-command --lock";
        locker = "${pkgs.lightlocker}/bin/light-locker-command --lock";
        notify = 30;
        notifier = "${pkgs.libnotify}/bin/notify-send 'Computer is locking in ${builtins.toString config.services.xserver.xautolock.notify} seconds'";
      };

      windowManager.i3 = {
        enable = true;
        extraSessionCommands = ''
          ${pkgs.xorg.xrdb}/bin/xrdb -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset}/bin/xset -b s off -dpms
          ${pkgs.feh}/bin/feh --bg-fill ~/.background-image
          cp $HOME/.config/alacritty/light.yml $HOME/.config/alacritty/alacritty.yml
          touch /tmp/lightmode
          ${pkgs.lxde.lxsession}/bin/lxpolkit &
          ${pkgs.xsettingsd}/bin/xsettingsd &
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
          darkman
        ];
      };
    };

    xrdp = {
      enable = true;
      defaultWindowManager = "i3";
      openFirewall = true;
    };

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
      HandleLidSwitch=suspend
    '';
  };

  programs = {
    dconf.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.xautolock}/bin/xautolock -locknow";
    };
  };
}
