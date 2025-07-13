{
  pkgs,
  headless,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      binutils
      coreutils
      diffutils
      findutils
      iputils
      inetutils
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
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      lact
    ]);

  programs = {
    htop.enable = true;
  };

  services = {
    sysstat.enable = true;
    rsyncd.enable = true;
    locate = {
      enable = true;
      package = pkgs.plocate;
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
