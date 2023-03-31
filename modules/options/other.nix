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
    octaveFull

    # Other packages
    zbar # Bar code reader
    qrencode # Generate QR codes
  ];
}
