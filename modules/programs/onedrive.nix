{ ... }:
{
  flake.modules.nixos.programs_onedrive =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        onedrive
      ];
    };
}
