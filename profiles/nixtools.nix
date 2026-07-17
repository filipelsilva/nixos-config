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
    programs.command-not-found.enable = false;

    programs.nix-index = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nix-search-cli
    nix-tree
    nixfmt
    nixfmt-tree
  ] ++ lib.lists.optionals isLinux [ cached-nix-shell ];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
