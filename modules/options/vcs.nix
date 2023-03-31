{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gitFull
    git-filter-repo
    gh
    glab
  ];
}
