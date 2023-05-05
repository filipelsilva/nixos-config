{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
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

      windowManager.i3 = {
        enable = true;
        extraSessionCommands = ''
          ${pkgs.autorandr}/bin/autorandr --change --skip-options crtc
          ${pkgs.xorg.xrdb}/bin/xrdb -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset}/bin/xset -b s off -dpms
          ${pkgs.feh}/bin/feh --bg-fill ~/.background-image
          ${pkgs.lxqt.qlipper}/bin/qlipper &
          ${pkgs.lxde.lxsession}/bin/lxpolkit &
        '';
        extraPackages = with pkgs; [
          i3status
          rofi
        ];
      };
    };
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
    '';
  };

  programs = {
    dconf.enable = true;
    i3lock.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    };
  };
}
