{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    lutris-free
    wineWow64Packages.stagingFull
  ];
}
