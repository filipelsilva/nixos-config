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

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    nm-applet.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    };
  };
}
