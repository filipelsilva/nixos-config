{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    ./overlays.nix
  ];

  systems = [ "x86_64-linux" ];

  perSystem =
    { system, ... }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = builtins.attrValues inputs.self.overlays;
      };
    in
    {
      _module.args.pkgs = pkgs;
      formatter = pkgs.nixfmt;
    };
}
