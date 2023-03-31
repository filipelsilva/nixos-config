{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [alacritty];
    variables = {
      TERMINAL = "alacritty";
    };
  };
}
