{
  pkgs,
  headless,
  ...
}: {
  environment.systemPackages = with pkgs; [] ++ lib.lists.optionals (!headless) (with pkgs; [virt-manager]);

  userConfig.extraGroups = ["libvirtd"];

  virtualisation.libvirtd.enable = true;
}
