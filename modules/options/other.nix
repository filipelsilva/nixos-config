{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Calculators
    bc
    libqalculate
    qalculate-qt
    octaveFull

    # Other packages
    zbar # Bar code reader
    qrencode # Generate QR codes
    ventoy-full # Make multiboot USB drives
  ];
}
