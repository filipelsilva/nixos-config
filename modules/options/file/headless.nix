{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    file
    magic-wormhole
    progress
    pipe-rename
    rename
    zoxide
    perl536Packages.FileMimeInfo # Detect MIME type of files
  ];

  boot.supportedFilesystems = ["ntfs"];
}
