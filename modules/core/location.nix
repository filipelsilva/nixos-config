{ ... }:
{
  flake.modules.nixos.core_location =
    { ... }:
    {
      location = {
        provider = "manual";
        latitude = 38.7;
        longitude = -9.1;
      };
    };
}
