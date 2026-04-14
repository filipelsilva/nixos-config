{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

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

  flake.overlays = {
    stable = final: _prev: {
      stable = import inputs.nixpkgs-stable { inherit (final) system config; };
    };
    rust-overlay = inputs.rust-overlay.overlays.default;
    copyparty = inputs.copyparty.overlays.default;
    nautilus = self: super: {
      gnome = super.gnome.overrideScope (
        gself: gsuper: {
          nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
            buildInputs =
              nsuper.buildInputs
              ++ (with self.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
          });
        }
      );
    };
  };
}
