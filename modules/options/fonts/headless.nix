{
  config,
  pkgs,
  inputs,
  ...
}: {
  fonts.fonts = with pkgs; [
    terminus_font
  ];
}
