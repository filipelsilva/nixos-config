{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gitFull
    git-filter-repo
    bfg-repo-cleaner
    gitleaks
    git-secrets
    gh
    glab
  ];
}
