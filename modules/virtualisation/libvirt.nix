{ pkgs, lib, ... }:
{
  flake.modules.nixos.virtualisation_libvirt =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (config.custom) headless;
    in
    {
      environment.systemPackages =
        with pkgs;
        [ ] ++ lib.lists.optionals (!headless) (with pkgs; [ virt-manager ]);

      userConfig.extraGroups = [ "libvirtd" ];

      virtualisation.libvirtd.enable = true;
    };
}
