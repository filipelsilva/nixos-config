{
  pkgs,
  lib,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    hunspell
    hunspellDicts.en_US
  ] ++ lib.lists.optionals isLinux [ libreoffice-qt ];
}
