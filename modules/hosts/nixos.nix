{ config, inputs, ... }:
let
  mkHost =
    hostname: extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        config.flake.modules.nixos.core_options
        config.flake.modules.nixos."host_${hostname}"
        { networking.hostName = hostname; }
      ]
      ++ extraModules;
      specialArgs = { inherit inputs; };
    };
in
{
  flake.nixosConfigurations = {
    Y540 = mkHost "Y540" [
      inputs.nixos-hardware.nixosModules.lenovo-legion-y530-15ich
    ];
    T490 = mkHost "T490" [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
    ];
    N100 = mkHost "N100" [ ];
  };
}
