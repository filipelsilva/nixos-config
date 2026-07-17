{
  pkgs,
  lib,
  system,
  headless,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    programs.htop.enable = true;

    services = {
      sysstat.enable = true;
      rsyncd.enable = true;
      locate = {
        enable = true;
        package = pkgs.plocate;
      };
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      binutils
      coreutils
      diffutils
      diffoscope
      findutils
      moreutils
      basez
      bottom
      tree
      bc # Calculator
      ascii
      cht-sh
      tealdeer
      (lib.hiPrio parallel)
      haskellPackages.words
    ]
    ++ lib.lists.optionals isLinux (
      with pkgs;
      [
        iputils
        inetutils
        pciutils
        psmisc
        procps
        nvtopPackages.full
      ]
    )
    ++ lib.lists.optionals (isLinux && !headless) (
      with pkgs;
      [
        lact
      ]
    );

  homeConfig = {
    home.file = {
      ".config/tealdeer/config.toml".text = ''
        [updates]
        auto_update = true
      '';
    };
  };
}
