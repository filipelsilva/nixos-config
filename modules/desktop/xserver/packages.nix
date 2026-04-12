{ pkgs, ... }:
{
  flake.modules.nixos.desktop_xserver-packages =
    { pkgs, ... }:
    {
      environment.variables = {
        QT_QPA_PLATFORMTHEME = "qt5ct";
      };

      environment.systemPackages = with pkgs; [
        arandr
        brightnessctl
        xdotool

        xclip
        xsel

        arc-theme
        lxappearance
        libsForQt5.qt5ct

        dragon-drop
        tigervnc
        remmina
        barrier
        scrcpy
        uxplay
      ];
    };
}
