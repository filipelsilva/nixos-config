{
  pkgs,
  lib,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  environment.systemPackages = with pkgs; [
    pandoc
    zathura
  ] ++ lib.lists.optionals isLinux [ diffpdf ];

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".config/zathura/zathurarc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/desktop/zathura/.config/zathura/zathurarc";
      };
    };
}
