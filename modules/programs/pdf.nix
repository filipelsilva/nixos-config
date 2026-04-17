{ ... }:
{
  flake.modules.nixos.programs_pdf =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        pandoc
        zathura
        diffpdf
      ];

      home-manager.users.${config.custom.user} =
        { config, ... }:
        {
          home.file = {
            ".config/zathura/zathurarc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
          };
        };
    };
}
