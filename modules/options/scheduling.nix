{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.cron.enable = true;

  environment.systemPackages = with pkgs; [
    at
  ];
}
