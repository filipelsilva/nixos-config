{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.auto-cpufreq.enable = true;
}
