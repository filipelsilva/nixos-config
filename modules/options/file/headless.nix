{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    magic-wormhole
    progress
    zoxide
    lsof
  ];

  boot.supportedFilesystems = ["ntfs"];
}
