{
  config,
  pkgs,
  inputs,
  ...
}: {
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

    xdragon # Drag-and-drop source/sink
    tigervnc # VNC server/client
    remmina # Remote desktop client
    barrier # KVM
    scrcpy # Android screen mirroring and control
    uxplay # AirPlay server
  ];
}
