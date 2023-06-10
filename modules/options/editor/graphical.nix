{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vscode-fhs
    jetbrains.jdk
    jetbrains-toolbox
  ];
}
