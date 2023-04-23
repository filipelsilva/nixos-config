{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      transmission
    ]
    ++ lib.lists.optionals (!headless) (with pkgs; [
      transmission-gtk
    ]);
}
