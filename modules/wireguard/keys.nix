{
  config,
  pkgs,
  ...
}: let
  keysFolder = "${config.userConfig.home}/.wireguard-keys";

  generateWGKeys = let
    wg = "${pkgs.wireguard-tools}/bin/wg";
  in
    pkgs.writeShellScript "generate-wg-keys" ''
      mkdir -p ${keysFolder}
      chown ${config.userConfig.name}:${config.userConfig.group} ${keysFolder}

      privateKey="${keysFolder}/private"
      publicKey="${keysFolder}/public"

      if [ ! -f "$privateKey" ]; then
        ${wg} genkey | tee "$privateKey" | ${wg} pubkey > "$publicKey"
        chmod 600 "$privateKey"
        chmod 644 "$publicKey"
        chown ${config.userConfig.name}:${config.userConfig.group} "$privateKey" "$publicKey"
      fi
    '';
in {
  system.activationScripts.generateWGKeys.text = "${generateWGKeys}";
}
