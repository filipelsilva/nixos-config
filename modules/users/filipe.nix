{ ... }:
{
  flake.nixosUserModules.filipe =
    { config, pkgs, ... }:
    {
      users.users.${config.custom.user} = {
        isNormalUser = true;
        initialPassword = "password";
        shell = pkgs.zsh;
        description = config.custom.userFullName;
        group = config.custom.user;
        extraGroups = [
          "wheel"
          "media"
        ];
      };
    };
}
