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
    lnav
    ctop

    neofetch
    onefetch
  ];

  programs = {
    htop.enable = true;
    iftop.enable = true;
    bandwhich.enable = true;
  };

  services.sysstat.enable = true;
}
