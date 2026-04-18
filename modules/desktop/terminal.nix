{ lib, ... }:
let
  forAllUsers = (import ../lib/_lib.nix { inherit lib; }).forAllUsers;
in
{
  flake.modules.nixos.desktop_terminal =
    {
      config,
      pkgs,
      lib,
      ...
    }:
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

      users.users = forAllUsers (lib.attrNames config.custom.users) (user: {
        extraGroups = [ "dialout" ];
      });

      home-manager.users = forAllUsers (lib.attrNames config.custom.users) (
        user:
        { config, ... }:
        {
          home.file = {
            ".config/alacritty".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/alacritty/.config/alacritty";
          };
        }
      );
    };
}
