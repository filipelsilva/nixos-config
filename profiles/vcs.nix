{
  pkgs,
  lib,
  system,
  ...
}:
let
  isLinux = lib.hasSuffix "linux" system;
in
{
  imports = lib.optional isLinux {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      lfs.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gh
  ] ++ lib.lists.optionals (!isLinux) [ git ];

  homeConfig =
    { config, ... }:
    {
      home.file = {
        ".gitconfig".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/git/.gitconfig";
      };
    };
}
