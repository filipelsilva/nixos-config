{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
    ];
  };
}
