{ ... }:
{
  flake.nixosUserModules.filipe =
    { pkgs, ... }:
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
    };
}
