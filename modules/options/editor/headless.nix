{
  config,
  pkgs,
  inputs,
  ...
}: let
  jdtlsWrapper = pkgs.writeShellScriptBin "jdtls" "jdt-language-server \"$@\"";
  neovim_packages = with pkgs; [
    # Language servers
    nodePackages_latest.bash-language-server
    clang-tools
    nodePackages_latest.dockerfile-language-server-nodejs
    nodePackages_latest.vscode-langservers-extracted
    gopls
    jdt-language-server
    lua-language-server
    nodePackages_latest.pyright
    nil
    rust-analyzer
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
      vim
      neovim
      neovim-remote
      d2

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
      ast-grep
      pdfgrep
      ripgrep
      ripgrep-all

      # Run commands when files change
      entr
      watchexec

      # Convert files to UNIX format
      dos2unix
    ]
    ++ [jdtlsWrapper]
    ++ neovim_packages;

  services = {
    rsyncd.enable = true;
    locate = {
      enable = true;
      locate = pkgs.plocate;
      localuser = null;
    };
  };
}
