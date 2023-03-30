{
  config,
  inputs,
  ...
}: {
  boot.loader.grub = {
    useOSProber = true;
    version = 2;
    efiSupport = true;
  };
}
