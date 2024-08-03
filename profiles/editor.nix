{
  pkgs,
  lib,
  headless,
  ...
}: let
  jdtlsWrapper = pkgs.writeShellScriptBin "jdtls" "jdt-language-server \"$@\"";
  neovimPackages = with pkgs; [
    # Language servers
    nodePackages_latest.bash-language-server
    clang-tools
    nodePackages_latest.dockerfile-language-server-nodejs
    gopls
    nodePackages_latest.vscode-langservers-extracted
    jdt-language-server
    lua-language-server
    nil
    pyright

    rust-analyzer
    terraform-ls
    texlab
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vim-language-server

    # Other stuff
    tree-sitter
  ];
in {
  environment.systemPackages = with pkgs;
    [
      ed
      gnused
      sd
      vimHugeX
      neovim
      neovim-remote

      # Pagers
      less
      lesspipe

      # Finders
      fzf
      fd
      silver-searcher
      pdfgrep
      ripgrep
      ripgrep-all

      bvi # Hex editor
      watchexec # Run commands when files change
      dos2unix # Convert files to UNIX format
    ]
    ++ [jdtlsWrapper]
    ++ neovimPackages
    ++ lib.lists.optionals (!headless) (with pkgs; [
      bless # Hex editor
    ]);

  services = {
    rsyncd.enable = true;
    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    };
  };
}
