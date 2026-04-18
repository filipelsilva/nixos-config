{ inputs, self, ... }:
let
  import-lib = import ../lib/_lib.nix { inherit (inputs.nixpkgs) lib; };
  mkHost =
    hostname: extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.modules.nixos.core_options
        self.modules.nixos."host_${hostname}"
        { networking.hostName = hostname; }
      ]
      ++ extraModules;
      specialArgs = {
        inherit inputs;
        inherit (self.flake) customDefaults;
        forAllUsers = customDefaults.forAllUsers;
      };
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
