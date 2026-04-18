{ ... }:
{
  flake.modules.nixos.programs_pdf =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        pandoc
        zathura
        diffpdf
      ];

      home-manager.users = forAllUsers (lib.attrNames config.custom.users) (
        user:
        { config, ... }:
        {
          home.file = {
            ".config/zathura/zathurarc".source =
              config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
          };
        }
      );
    };
}
