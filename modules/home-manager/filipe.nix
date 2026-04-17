{ ... }:
{
  flake.homeManagerModules.filipe =
    { config, pkgs, ... }:
    {
      home.username = "filipe";
      home.homeDirectory = "/home/filipe";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
}
