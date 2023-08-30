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
  ];
}
