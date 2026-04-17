{ ... }:
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

      users.users.${config.custom.user}.extraGroups = [ "libvirtd" ];

      virtualisation.libvirtd.enable = true;
    };
}
