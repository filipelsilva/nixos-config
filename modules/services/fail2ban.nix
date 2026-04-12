{ ... }:
{
  flake.modules.nixos.services_fail2ban =
    { ... }:
    {
      services.fail2ban = {
        enable = true;
        maxretry = 3;
        bantime = "10m";
        bantime-increment = {
          enable = true;
          rndtime = "8min";
          maxtime = "24h";
        };
      };
    };
}
