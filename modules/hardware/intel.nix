{
  config,
  pkgs,
  lib,
  ...
}:
{
  flake.modules.nixos.hardware_intel =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      hardware.graphics = {
        enable = true;
        extraPackages =
          with pkgs;
          [
            intel-media-driver
            libva-vdpau-driver
            intel-compute-runtime
            vpl-gpu-rt
          ]
          ++ lib.optional (config.networking.hostName != "T490") (
            intel-vaapi-driver.override { enableHybridCodec = true; }
          );
      };
    };
}
