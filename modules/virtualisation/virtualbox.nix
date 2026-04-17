{ ... }:
{
  flake.modules.nixos.virtualisation_virtualbox =
    { config, ... }:
    {
      users.users.${config.custom.user}.extraGroups = [ "vboxusers" ];

      virtualisation.virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = false;
        };
      };
    };
}
