{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment = {
    variables = {
      TERMINAL = "alacritty";
    };
  };

  location.provider = "geoclue2";

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    nm-applet.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    };
  };

  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 6500;
        night = 4500;
      };
    };
  };
}
