{ lib, ... }:
let
  forAllUsers = (import ../lib/_lib.nix { inherit lib; }).forAllUsers;
in
{
  flake.modules.nixos.virtualisation_virtualbox =
    { config, lib, ... }:
    {
      users.users = forAllUsers (lib.attrNames config.custom.users) (user: {
        extraGroups = [ "vboxusers" ];
      });

      virtualisation.virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = false;
        };
      };
    };
}
