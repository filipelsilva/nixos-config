{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cached-nix-shell
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
