{pkgs, ...}: {
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
    gnome.pomodoro # Pomodoro timer
    calibre # E-book software
  ];
}
