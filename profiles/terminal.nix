{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    userConfig.extraGroups = [ "dialout" ]; # For using serial connections
  };

  environment = {
    systemPackages = with pkgs; [
      alacritty
    ] ++ lib.lists.optionals isLinux [ gtkterm ];
    variables = {
      TERMINAL = "alacritty";
    };
  };

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".config/alacritty".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
      };
    };
}
