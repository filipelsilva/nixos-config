{ lib, ... }:
let
  forAllUsers = (import ../lib/_lib.nix { inherit lib; }).forAllUsers;
in
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

      users.users = forAllUsers (lib.attrNames config.custom.users) (user: {
        extraGroups = [ "libvirtd" ];
      });

      virtualisation.libvirtd.enable = true;
    };
}
