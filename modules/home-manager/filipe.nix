{ ... }:
{
  flake.homeManagerModules.filipe =
    { config, pkgs, ... }:
    {
      home.username = config.custom.user;
      home.homeDirectory = config.custom.home;
      home.stateVersion = config.system.stateVersion;
      programs.home-manager.enable = true;
    };
}
