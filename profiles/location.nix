let
  loc = import ./location-shared.nix;
in
{ ... }:
{
  location = {
    provider = "manual";
    latitude = loc.latitude;
    longitude = loc.longitude;
  };
}
