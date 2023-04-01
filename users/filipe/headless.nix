{
  config,
  pkgs,
  ...
}: {
  home.username = "filipe";
  home.homeDirectory = "/home/filipe";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
    ];
  };

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/nvim/.config/nvim";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/git/.gitconfig";
    ".inputrc".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/readline/.inputrc";
    ".screenrc".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/screen/.screenrc";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/tmux/.tmux.conf";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/vim/.vimrc";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/zsh/.zshrc";

    ".config/tealdeer/config.toml".text = ''
      [updates]
      auto_update = true
    '';
  };
}
