{
  config,
  pkgs,
  lib,
  user,
  userFullName,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  imports = [
    (lib.mkAliasOptionModule [ "homeConfig" ] [ "home-manager" "users" "${user}" ])
    (lib.mkAliasOptionModule [ "userConfig" ] [ "users" "users" "${user}" ])
  ];

  users.groups.${user} = lib.mkIf (!isDarwin) { };
  users.groups.media = lib.mkIf (!isDarwin) { };

  userConfig =
    if isDarwin then
      {
        home = "/Users/${user}";
        shell = pkgs.zsh;
        description = userFullName;
      }
    else
      {
        isNormalUser = true;
        initialPassword = "password";
        shell = pkgs.zsh;
        description = userFullName;
        group = user;
        extraGroups = [
          "wheel"
          "media"
        ];
      };

  homeConfig = {
    home.username = user;
    home.homeDirectory = "/${if isDarwin then "Users" else "home"}/${user}";
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;
  };
}
