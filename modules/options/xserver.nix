{
  config,
  inputs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "altgr-intl"; # TODO change this someday
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          horizontalScrolling = true;
          naturalScrolling = false;
        };
        touchpad = {
          accelProfile = "flat";
          horizontalScrolling = true;
          naturalScrolling = true;
          scrollMethod = "twofinger";
          tapping = true;
        };
      };
      desktopManager = {
        wallpaper = {
          combineScreens = false;
          mode = "fill";
        };
      };
      displayManager = {
        defaultSession = "none+i3";
        startx.enable = true;
      };
    };
  };
  windowManager.i3 = {
    enable = true;
    extraSessionCommands = ''
      xrdb -merge -I$HOME ~/.Xresources
      xset s off && xset -b -dpms
    '';
    extraPackages = with pkgs; [
      i3
      i3status
      i3lock
      xss-lock
      rofi
    ];
  };
  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock}/bin/i3lock";
  };
}
