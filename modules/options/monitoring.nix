{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    procps
    procs
    bottom
    nethogs
    nvtop
  ];

  programs = {
    htop.enable = true;
    iftop.enable = true;
    bandwhich.enable = true;
  };

  services.sysstat.enable = true;
}
