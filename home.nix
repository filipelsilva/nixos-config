{ config, pkgs, ... }:

let 
    user = "filipe";
    home = "/home/${user}";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${user}";
  home.homeDirectory = "${home}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      plugins = [
        {
          name = "forgit";
          src = builtins.fetchGit {
            url = "https://github.com/wfxr/forgit.git";
          };
        }
      ];
    };
  };

  # FIXME ver de onChange
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

    ".zshenv" = {
      text = ''
        echo setopt no_global_rcs
      '';
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
