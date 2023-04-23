{
  config,
  pkgs,
  inputs,
  ...
}: {
  services = {
    xserver.libinput = {
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
  };
}
