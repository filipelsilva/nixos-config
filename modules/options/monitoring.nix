{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    procps
    bottom
    nvtop

    neofetch
  ];

  programs = {
    htop.enable = true;
  };

  services.sysstat.enable = true;
}
