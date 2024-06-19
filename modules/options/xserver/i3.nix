{
  config,
  pkgs,
  lib,
  ...
}: {
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
          cp $HOME/.config/alacritty/light.yml $HOME/.config/alacritty/alacritty.yml
          ${pkgs.xorg.xrdb}/bin/xrdb -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset}/bin/xset -b s off -dpms
          ${pkgs.feh}/bin/feh --bg-fill ~/.background-image
          ${pkgs.lxde.lxsession}/bin/lxpolkit &
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

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
      HandleLidSwitch=suspend
    '';
  };

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.lightlocker}/bin/light-locker-command --lock";
    };
  };
}
