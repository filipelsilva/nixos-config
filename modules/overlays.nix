{ inputs, ... }:
{
  flake.overlays = {
    # access to nixpkgs-stable
    stable = final: _prev: {
      stable = import inputs.nixpkgs-stable { inherit (final) system config; };
    };

    # Rust toolchain overlay
    rust-overlay = inputs.rust-overlay.overlays.default;

    # Copyparty overlay
    copyparty = inputs.copyparty.overlays.default;

    # Nautilus with additional gstreamer plugins
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
