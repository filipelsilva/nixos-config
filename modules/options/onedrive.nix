{
  config,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.onedrive
  ];
}
