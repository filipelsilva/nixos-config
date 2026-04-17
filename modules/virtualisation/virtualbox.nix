{ ... }:
{
  flake.modules.nixos.virtualisation_virtualbox =
    { ... }:
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
