{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lxde.lxsession
  ];

  security.polkit.enable = true;
}
