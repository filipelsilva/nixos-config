{ ... }:
{
  flake.modules.nixos.virtualisation_virtualbox =
    { ... }:
    {
      userConfig.extraGroups = [ "vboxusers" ];

      virtualisation.virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = false;
        };
      };
    };
}
