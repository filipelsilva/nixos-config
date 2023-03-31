{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        vscodevim.vim
      ];
    })
    jetbrains.jdk
    jetbrains.idea-ultimate
  ];
}
