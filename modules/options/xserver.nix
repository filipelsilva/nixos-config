{
  config,
  inputs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "altgr-intl";
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
        startx.enable = true; # TODO deploy with this line
      };
    };
  };
}
