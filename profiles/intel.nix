{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs;
      [
        intel-media-driver
        vaapiVdpau
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
        vpl-gpu-rt # QSV on 11th gen or newer
      ]
      ++ lib.optional (config.networking.hostName != "T490") (
        intel-vaapi-driver.override {enableHybridCodec = true;} # previously vaapiIntel
      );
  };
}
