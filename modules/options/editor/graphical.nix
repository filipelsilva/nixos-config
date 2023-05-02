{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vscode-fhs
    jetbrains.jdk
    jetbrains.idea-ultimate
  ];
}
