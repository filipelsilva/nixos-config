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
        accelSpeed = "1";
        horizontalScrolling = true;
        naturalScrolling = false;
      };

      touchpad = {
        accelProfile = "flat";
        accelSpeed = "1";
        horizontalScrolling = true;
        naturalScrolling = true;
        scrollMethod = "twofinger";
        tapping = true;
      };
    };
  };
}
