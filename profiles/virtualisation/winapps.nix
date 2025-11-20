{
  inputs,
  pkgs,
  ...
}: {
  # https://github.com/winapps-org/winapps
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages.${stdenv.hostPlatform.system}.winapps
    inputs.winapps.packages.${stdenv.hostPlatform.system}.winapps-launcher
  ];
}
