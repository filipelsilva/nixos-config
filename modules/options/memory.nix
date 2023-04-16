{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    duf
    du-dust
    diskus
    ncdu
    dua
    fdupes
    gparted # TODO check if parted comes with it
  ];
}
