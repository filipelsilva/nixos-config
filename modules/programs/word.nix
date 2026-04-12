{ pkgs, ... }:
{
  flake.modules.nixos.programs_word =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        texlive.combined.scheme-full
        libreoffice-qt
        hunspell
        hunspellDicts.en_US
      ];
    };
}
