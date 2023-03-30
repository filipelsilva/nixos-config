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
}
