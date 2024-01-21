{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    nix-search-cli
    nix-index
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
