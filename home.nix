{ config, pkgs, ... }:
let 
    user = "filipe";
    home = "/home/${user}";
in
{
  home.username = "${user}";
  home.homeDirectory = "${home}";

  home.stateVersion = "22.11";

  programs = {
    home-manager.enable = true;
    zsh.enable = true;
  };

  home.file = {
    ".gitconfig" = {
      text = builtins.readFile "${home}/dotfiles/files/gitconfig";
    };

    ".config/nvim/init.vim" = {
      text = builtins.readFile "${home}/dotfiles/files/init.vim";
    };

    ".inputrc" = {
      text = builtins.readFile "${home}/dotfiles/files/inputrc";
    };

    ".tmux.conf" = {
      text = builtins.readFile "${home}/dotfiles/files/tmux.conf";
    };

    ".vimrc" = {
      text = builtins.readFile "${home}/dotfiles/files/vimrc";
    };

    ".zshrc" = {
      text = builtins.readFile "${home}/dotfiles/files/zshrc";
    };

    ".alacritty.yml" = {
      text = builtins.readFile "${home}/dotfiles/files/alacritty.yml";
    };

    ".config/i3/config" = {
      text = builtins.readFile "${home}/dotfiles/files/i3config";
    };

    ".config/i3status/config" = {
      text = builtins.readFile "${home}/dotfiles/files/i3statusconfig";
    };

    ".config/zathura/zathurarc" = {
      text = builtins.readFile "${home}/dotfiles/files/zathurarc";
    };
  };
}
