{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    diffutils
    findutils
    iputils
    moreutils
    pciutils
  ];
}
