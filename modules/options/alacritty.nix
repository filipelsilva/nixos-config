{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      alacritty
      gnome.gnome-terminal
    ];
    variables = {
      TERMINAL = "alacritty";
    };
  };
}
