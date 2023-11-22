{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    magic-wormhole
    croc
    progress
    rename
    zoxide
    perl536Packages.FileMimeInfo # Detect MIME type of files
    lsof
  ];

  boot.supportedFilesystems = ["ntfs"];
}
