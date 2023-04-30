{
  config,
  pkgs,
  inputs,
  ...
}: {
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    linux-firmware
    util-linux
  ];
}
