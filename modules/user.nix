{
  user,
  userFullName,
  pkgs,
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
}
