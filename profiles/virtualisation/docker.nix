{
  config,
  lib,
  ...
}: {
  userConfig.extraGroups = ["docker"];

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = lib.mkIf (builtins.any (x: x == "nvidia") config.services.xserver.videoDrivers) true;
      rootless.enable = true;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  hardware.nvidia-container-toolkit.enable = lib.mkIf (builtins.any (x: x == "nvidia") config.services.xserver.videoDrivers) true;
}
