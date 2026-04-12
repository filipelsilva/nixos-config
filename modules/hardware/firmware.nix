{ ... }:
{
  flake.modules.nixos.hardware_firmware =
    { ... }:
    {
      hardware.enableRedistributableFirmware = true;
      services.fwupd.enable = true;
    };
}
