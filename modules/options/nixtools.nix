{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    nix-search-cli
    nix-tree
  ];

  programs = {
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
