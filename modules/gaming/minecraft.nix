{ pkgs, ... }:
{
  flake.modules.nixos.gaming_minecraft =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        prismlauncher
      ];
    };
}
