{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.java.package = lib.mkForce pkgs.jetbrains.jdk;

  environment.systemPackages = with pkgs; [
    vscode-fhs
    jetbrains.jdk
    jetbrains.idea-ultimate
  ];
}
