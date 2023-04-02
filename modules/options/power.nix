{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.auto-cpufreq.enable = true;
  # powerManagement.cpuFreqGovernor = "conservative"; # TODO see this
}
