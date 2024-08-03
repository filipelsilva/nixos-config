{pkgs, ...}: {
  environment.systemPackages = with pkgs; [virt-manager];

  userConfig.extraGroups = ["libvirtd"];

  virtualisation.libvirtd.enable = true;
}
