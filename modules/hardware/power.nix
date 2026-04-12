{ ... }:
{
  flake.modules.nixos.hardware_power =
    { ... }:
    {
      services = {
        auto-cpufreq.enable = true;
        thermald.enable = true;
        tlp.enable = true;
      };
    };
}
