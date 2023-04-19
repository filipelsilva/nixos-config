{
  config,
  pkgs,
  ...
}: {
  home.username = "filipe";
  home.homeDirectory = "/home/filipe";

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/nvim/.config/nvim";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/git/.gitconfig";
    ".inputrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/readline/.inputrc";
    ".screenrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/screen/.screenrc";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/tmux/.tmux.conf";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/vim/.vimrc";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/zsh/.zshrc";

    ".config/tealdeer/config.toml".text = ''
      [updates]
      auto_update = true
    '';
  };
}
