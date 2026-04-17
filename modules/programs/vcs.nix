{ ... }:
{
  flake.modules.nixos.programs_vcs =
    { config, pkgs, ... }:
    {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        lfs.enable = true;
      };

      environment.systemPackages = with pkgs; [
        gh
      ];

      home-manager.users.${config.custom.user} =
        { config, ... }:
        {
          home.file = {
            ".gitconfig".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/git/.gitconfig";
          };
        };
    };
}
