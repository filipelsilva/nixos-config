{ ... }:
{
  flake.modules.nixos.core_scheduling =
    { pkgs, ... }:
    {
      services.cron.enable = true;

      environment.systemPackages = with pkgs; [
        at
      ];
    };
}
