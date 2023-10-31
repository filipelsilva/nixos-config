{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    piper
  ];

  services = {
    xserver.libinput = {
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
}
