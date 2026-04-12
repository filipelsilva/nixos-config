{ inputs, pkgs, ... }:
{
  flake.modules.nixos.virtualisation_winapps =
    { inputs, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        inputs.winapps.packages.${stdenv.hostPlatform.system}.winapps
        inputs.winapps.packages.${stdenv.hostPlatform.system}.winapps-launcher
      ];
    };
}
