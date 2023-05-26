{
  config,
  pkgs,
  inputs,
  ...
}: let
  jdtlsWrapper = pkgs.writeShellScriptBin "jdtls" "jdt-language-server \"$@\"";
  neovim_lsp_packages = with pkgs; [
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
  ];
in {
  environment.systemPackages =
    [jdtlsWrapper]
    ++ (with pkgs; [
      ed
      gnused
      sd
      vim
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
      ast-grep
      pdfgrep
      ripgrep
      ripgrep-all

      # Run commands when files change
      entr
      watchexec

      # Convert files to UNIX format
      dos2unix
    ])
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
