{pkgs, ...}: {
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    arandr
    brightnessctl
    xdotool

    # Clipboard management
    xclip
    xsel

    # Theme management
    arc-theme
    lxappearance
    libsForQt5.qt5ct

    xdragon # Drag-and-drop source/sink
    tigervnc # VNC server/client
    remmina # Remote desktop client
    barrier # KVM
    scrcpy # Android screen mirroring and control
    uxplay # AirPlay server
  ];
}
