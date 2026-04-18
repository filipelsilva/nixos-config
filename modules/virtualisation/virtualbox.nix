{ ... }:
{
  flake.modules.nixos.virtualisation_virtualbox =
    { config, lib, ... }:
    {
      users.users = inputs.self.flake.customDefaults.forAllUsers (lib.attrNames config.custom.users) (user: {
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
