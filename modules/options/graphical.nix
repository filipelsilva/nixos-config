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

  sound.enable = true;

  location.provider = "geoclue2";

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    nm-applet.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "zathura.desktop";
    "image/jpeg" = "sxiv.desktop";
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
