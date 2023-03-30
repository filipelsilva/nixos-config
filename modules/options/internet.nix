{
  config,
  inputs,
  ...
}: {
  programs.nm-applet = {
    enable = true;
    indicator = false; # TODO check this
  };
}
