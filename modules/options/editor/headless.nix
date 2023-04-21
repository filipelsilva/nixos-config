{
  config,
  pkgs,
  inputs,
  ...
}: let
  neovim_lsp_packages = with pkgs; [
    nodePackages_latest.bash-language-server
    clang-tools
    nodePackages_latest.dockerfile-language-server-nodejs
    nodePackages_latest.vscode-langservers-extracted
    gopls
    jdt-language-server
    lua-language-server
    nodePackages_latest.pyright
    rnix-lsp
    rust-analyzer
    terraform-ls
    texlab
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vim-language-server
  ];
in {
  environment.systemPackages = with pkgs;
    [
      ed
      gnused
      sd
      vimHugeX
      neovim

      bvi
      bless # Hex editor

      # Pagers
      less
      lesspipe
      bat
      hexyl

      # Finders
      fzf
      fd
      silver-searcher
      pdfgrep
      ripgrep
      ripgrep-all

      # Run commands when files change
      entr
      watchexec
    ]
    ++ neovim_lsp_packages;

  services = {
    rsyncd.enable = true;
    locate = {
      enable = true;
      locate = pkgs.plocate;
      localuser = null;
    };
  };
}
