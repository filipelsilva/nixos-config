{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    piper
  ];

  services.ratbagd.enable = true;
}
