{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git-filter-repo
    bfg-repo-cleaner
    gitleaks
    git-secrets
    gh
    glab
  ];
}
