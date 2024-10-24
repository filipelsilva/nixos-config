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
    tree
    ascii
    cht-sh
    tealdeer
    (lib.hiPrio parallel)
    haskellPackages.words
    fpp # Facebook Path Picker
  ];

  programs = {
    htop.enable = true;
  };

  services = {
    sysstat.enable = true;
    rsyncd.enable = true;
    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    };
  };

  homeConfig = {
    home.file = {
      ".config/tealdeer/config.toml".text = ''
        [updates]
        auto_update = true
      '';
    };
  };
}
