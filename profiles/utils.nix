{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    diffutils
    findutils
    iputils
    moreutils
    pciutils
    psmisc
    basez
    procps
    bottom
    nvtopPackages.full
  ];

  programs = {
    htop.enable = true;
  };

  services.sysstat.enable = true;
}
