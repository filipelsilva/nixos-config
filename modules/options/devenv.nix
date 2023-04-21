{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.devenv.packages.${pkgs.system}.devenv
  ];
}
