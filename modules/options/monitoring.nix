{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    procps
    bottom
    nvtopPackages.full
  ];

  programs = {
    htop.enable = true;
  };

  services.sysstat.enable = true;
}
