{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    procps
    bottom
    nvtopPackages.full

    neofetch
  ];

  programs = {
    htop.enable = true;
  };

  services.sysstat.enable = true;
}
