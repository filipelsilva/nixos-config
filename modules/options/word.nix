{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
  ];
}
