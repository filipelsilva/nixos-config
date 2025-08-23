{
  inputs,
  pkgs,
  ...
}: {
  # https://github.com/winapps-org/winapps
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages.${system}.winapps
    inputs.winapps.packages.${system}.winapps-launcher
  ];
}
