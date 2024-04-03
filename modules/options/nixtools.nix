{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    nix-search-cli
    nix-index
    nix-tree
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
