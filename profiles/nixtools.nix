{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    nix-search-cli
    nix-tree
    inputs.alejandra.defaultPackage.${stdenv.hostPlatform.system}
  ];

  programs = {
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    nix-index-database.comma.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
