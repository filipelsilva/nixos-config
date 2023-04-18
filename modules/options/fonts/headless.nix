{
  config,
  pkgs,
  inputs,
  ...
}: {
  console.packages = with pkgs; [
    terminus_font
  ];
}
