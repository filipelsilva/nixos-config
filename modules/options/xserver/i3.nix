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
          ${pkgs.xorg.xrdb} -merge -I$HOME ~/.Xresources
          ${pkgs.xorg.xset} s off && ${pkgs.xorg.xset} -b -dpms
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
