{
  config,
  pkgs,
  inputs,
  ...
}: {
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
}
