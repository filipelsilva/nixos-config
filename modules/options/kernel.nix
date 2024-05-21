{pkgs, ...}: {
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "wasm32-wasi"
      "x86_64-windows"
    ];
  };
}
