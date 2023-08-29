{pkgs, ...}: {
  services.cron.enable = true;

  environment.systemPackages = with pkgs; [
    at
  ];
}
