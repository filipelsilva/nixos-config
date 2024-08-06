{pkgs, ...}: {
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    screen
  ];

  homeConfig = {config, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "tms" (builtins.readFile "${config.home.homeDirectory}/dotfiles/scripts/tmux-sessionizer.sh"))
    ];
    home.file = {
      ".screenrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/screen/.screenrc";
      ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/tmux/.tmux.conf";
    };
  };
}
