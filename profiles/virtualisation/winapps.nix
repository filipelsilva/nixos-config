{
  inputs,
  pkgs,
  ...
}:
{
  # https://github.com/winapps-org/winapps
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system}.winapps
    inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system}.winapps-launcher
  ];
}
