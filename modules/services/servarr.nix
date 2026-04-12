{ ... }:
{
  flake.modules.nixos.services_servarr =
    { ... }:
    {
      services = {
        prowlarr = {
          enable = true;
        };

        flaresolverr = {
          # enable = true;
        };

        radarr = {
          enable = true;
        };
        sonarr = {
          # enable = true;
        };
        readarr = {
          enable = true;
        };
        lidarr = {
          enable = true;
        };
      };
    };
}
