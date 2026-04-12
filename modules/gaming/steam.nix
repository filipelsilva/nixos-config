{ ... }:
{
  flake.modules.nixos.gaming_steam =
    { ... }:
    {
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
        };
      };
      hardware.steam-hardware.enable = true;
    };
}
