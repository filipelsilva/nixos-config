{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "wasm32-wasi"
      "x86_64-windows"
    ];
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
    util-linux
  ];
}
