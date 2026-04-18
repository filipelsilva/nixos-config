{ ... }:
{
  flake.modules.nixos.filipe =
    { config, pkgs, ... }:
    {
      users.users.filipe = {
        isNormalUser = true;
        initialPassword = "password";
        shell = pkgs.zsh;
        description = "Filipe Ligeiro Silva";
        group = "filipe";
        extraGroups = [
          "wheel"
          "media"
        ];
      };

      users.groups.filipe = { };

      home-manager.users.filipe = {
        home.username = "filipe";
        home.homeDirectory = "/home/filipe";
        home.stateVersion = config.system.stateVersion;
        programs.home-manager.enable = true;
      };
    };
}
