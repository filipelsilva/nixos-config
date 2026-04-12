{ pkgs, ... }:
{
  flake.modules.nixos.desktop_mouse =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        piper
      ];

      services = {
        libinput = {
          enable = true;
          mouse = {
            accelProfile = "flat";
            horizontalScrolling = true;
            naturalScrolling = false;
          };
          touchpad = {
            accelProfile = "adaptive";
            horizontalScrolling = true;
            naturalScrolling = true;
            scrollMethod = "twofinger";
            tapping = true;
          };
        };
        ratbagd.enable = true;
      };
    };
}
