{config, ...}: let
  spell-pt-utf-8-spl = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.utf-8.spl";
    sha256 = "3e5fc100b6951b783cfb3386ada43cb39839553e04faa415af5cf5bd5d6ab63b";
  };

  spell-pt-latin1-spl = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/pt.latin1.spl";
    sha256 = "3c1c362335424c890e683ec99674df8b69dc706b1366fbc205e3955436518680";
  };

  spell-en-utf-8-spl = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl";
    sha256 = "fecabdc949b6a39d32c0899fa2545eab25e63f2ed0a33c4ad1511426384d3070";
  };

  spell-en-utf-8-sug = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.utf-8.sug";
    sha256 = "5b6e5e6165582d2fd7a1bfa41fbce8242c72476222c55d17c2aa2ba933c932ec";
  };

  spell-en-latin1-spl = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.latin1.spl";
    sha256 = "620d9efcd79cfc9d639818fb52807e3dae61a37c800d694a010cd525a2161845";
  };

  spell-en-latin1-sug = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.latin1.sug";
    sha256 = "e6de97e4bcb3f9b4aaf7e1eb54a81b9390d5c231f427fa4be3798a25e4622b02";
  };

  spell-en-ascii-spl = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.ascii.spl";
    sha256 = "cebcba489d45da3355940f340582e20ce35ecdcd44f9cc168be873f08e782449";
  };

  spell-en-ascii-sug = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/en.ascii.sug";
    sha256 = "b0d5d0ed19735f837248ef97bccb444ad730340b1785c8f6a8e4458f6872216c";
  };
in {
  home.username = "filipe";
  home.homeDirectory = "/home/filipe";

  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/git/.gitconfig";
    ".inputrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/readline/.inputrc";
    ".screenrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/screen/.screenrc";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/tmux/.tmux.conf";
    ".vim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/vim/.vim";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/zsh/.zshrc";
    ".lesskey".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/less/.lesskey";

    ".config/tealdeer/config.toml".text = ''
      [updates]
      auto_update = true
    '';

    ".config/direnv/direnvrc".text = ''
      source /run/current-system/sw/share/nix-direnv/direnvrc
    '';

    ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/nvim/.config/nvim/init.lua";
    ".config/nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/nvim/.config/nvim/lua";
    ".config/nvim/after".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/headless/nvim/.config/nvim/after";

    ".config/nvim/spell/pt.utf-8.spl".source = spell-pt-utf-8-spl;
    ".config/nvim/spell/pt.latin1.spl".source = spell-pt-latin1-spl;
    ".config/nvim/spell/en.utf-8.spl".source = spell-en-utf-8-spl;
    ".config/nvim/spell/en.utf-8.sug".source = spell-en-utf-8-sug;
    ".config/nvim/spell/en.latin1.spl".source = spell-en-latin1-spl;
    ".config/nvim/spell/en.latin1.sug".source = spell-en-latin1-sug;
    ".config/nvim/spell/en.ascii.spl".source = spell-en-ascii-spl;
    ".config/nvim/spell/en.ascii.sug".source = spell-en-ascii-sug;
  };
}
