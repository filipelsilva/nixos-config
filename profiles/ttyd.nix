{
  inputs,
  config,
  ...
}: {
  age.secrets."ttyd-password".file = "${inputs.self.outPath}/secrets/ttyd-password.age";

  services.ttyd = {
    enable = true;
    writeable = true;
    terminalType = "alacritty";
    username = config.userConfig.name;
    passwordFile = config.age.secrets."ttyd-password".path;
  };
}
