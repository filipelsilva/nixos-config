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
          ${pkgs.xorg.xrdb}/bin/xrdb -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset}/bin/xset s off && ${pkgs.xorg.xset}/bin/xset -b -dpms
          ${pkgs.lxde.lxsession}/bin/lxpolkit &
        '';
        extraPackages = with pkgs; [
          i3status
          rofi
        ];
      };
    };
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
