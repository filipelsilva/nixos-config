{ ... }:
{
  flake.modules.nixos.desktop_terminal =
    { config, pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          alacritty
          gtkterm
        ];
        variables = {
          TERMINAL = "alacritty";
        };
      };

      users.users.${config.custom.user}.extraGroups = [ "dialout" ]; # For using serial connections

      home-manager.users.${config.custom.user} =
        { config, ... }:
        {
          home.file = {
            ".config/alacritty".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
          };
        };
    };
}
