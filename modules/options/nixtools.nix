{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  environment.systemPackages = with pkgs; [
    inputs.devenv.packages.${pkgs.system}.devenv
    direnv
    nix-direnv
    cached-nix-shell
  ];

  nixpkgs.overlays = [
    (self: super: {nix-direnv = super.nix-direnv.override {enableFlakes = true;};})
  ];
}
