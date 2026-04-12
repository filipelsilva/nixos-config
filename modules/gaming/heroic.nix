{ pkgs, ... }:
{
  flake.modules.nixos.gaming_heroic =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        heroic
      ];
    };
}
