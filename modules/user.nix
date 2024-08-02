{
  config,
  pkgs,
  user,
  userFullName,
  ...
}: {
  users = {
    groups.${user} = {
      name = user;
      members = [user];
    };
    users.${user} = {
      isNormalUser = true;
      initialPassword = "password";
      shell = pkgs.zsh;
      description = userFullName;
      group = user;
      extraGroups = [
        "audio"
        "docker"
        "dialout"
        "libvirtd"
        "networkmanager"
        "storage"
        "vboxusers"
        "video"
        "wheel"
      ];
    };
  };

  home-manager.users.${user} = {
    home.username = user;
    home.homeDirectory = "/home/${user}";
    home.stateVersion = config.system.stateVersion;
    programs.home-manager.enable = true;
  };
}
