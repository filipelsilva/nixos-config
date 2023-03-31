{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    arandr
    autorandr
    brightnessctl
    xdotool

    # Clipboard management
    xclip
    xsel

    # Theme management
    arc-theme
    lxappearance

    xdragon # Drag-and-drop source/sink
    tigervnc # VNC server/client
    remmina # Remote desktop client
    barrier # KVM
    scrcpy # Android screen mirroring and control
    uxplay # AirPlay server
  ];

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
      rofi
      i3status
      i3lock
    ];
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock}/bin/i3lock";
  };
}
