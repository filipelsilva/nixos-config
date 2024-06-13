# Dominik Schrempf: https://dschrempf.github.io/linux/2024-02-14-monitoring-a-home-server/
{
  filesystems, # List of monitored file system paths.
  drives, # List of monitored drives.
  zpools, # List of monitored ZFS pools
  allowIps, # Allow access from these IP addresses.
  openPort, # Open Monit TCP port in firewall?
}: {
  lib,
  pkgs,
  ...
}: let
  port = 2812;
  hdTemp = pkgs.writeShellScript "hd-temp" ''
    SMARTCTL_OUTPUT=$(${pkgs.smartmontools}/bin/smartctl --json=c --nocheck=standby -A "/dev/$1")
    if [[ "$?" = "2" ]]; then
        echo "STANDBY"
        exit 0
    fi
    TEMPERATURE=$(${pkgs.jq}/bin/jq '.temperature.current' <<< "$SMARTCTL_OUTPUT")
    echo "$TEMPERATURE"°C
    exit "$TEMPERATURE"
  '';
  hdStatus = pkgs.writeShellScript "hd-status" ''
    SMARTCTL_OUTPUT=$(${pkgs.smartmontools}/bin/smartctl --json=c --nocheck=standby -H "/dev/$1")
    if [[ "$?" = "2" ]]; then
        echo "STANDBY"
        exit 0
    fi
    PASSED=$(${pkgs.jq}/bin/jq '.smart_status.passed' <<< "$SMARTCTL_OUTPUT")
    if [ "$PASSED" = "true" ]
    then
        echo "PASSED"
        exit 0
    else
        echo "FAULTY"
        exit 1
    fi
  '';
  monitorGeneral = ''
    set daemon 3600
    set logfile /var/log/monit.log
    set httpd port ${builtins.toString port}
       allow localhost ${lib.strings.concatMapStringsSep " " (ip: "allow " + ip) allowIps}'';
  monitorSystem = ''
    check system $HOST
      if loadavg (15min) > 5 for 5 times within 15 cycles then alert
      if memory usage > 80% for 4 cycles then alert
      if swap usage > 20% for 4 cycles then alert'';
  monitorFilesystem = fs: ''
    check filesystem "path ${fs}" with path ${fs}
      if space usage > 90% then alert'';
  monitorFilesystems = lib.strings.concatMapStringsSep "\n" monitorFilesystem filesystems;
  monitorDriveTemperature = drive: ''
    check program "drive temperature: ${drive}" with path "${hdTemp} ${drive}"
      every 5 cycles
      if status > 40 then alert
      group health'';
  monitorDriveTemperatures = lib.strings.concatMapStringsSep "\n" monitorDriveTemperature drives;
  monitorDriveStatus = drive: ''
    check program "drive status: ${drive}" with path "${hdStatus} ${drive}"
      every 12 cycles
      if status > 0 then alert
      group health'';
  monitorDriveStatuses = lib.strings.concatMapStringsSep "\n" monitorDriveStatus drives;
  monitorZpoolStatus = zpool: ''
    check program "zpool status: ${zpool}" with path "${pkgs.zfs}/bin/zpool status ${zpool}"
      if content != "state: ONLINE" then alert
      group heatlh;'';
  monitorZpoolStatuses = lib.strings.concatMapStringsSep "\n" monitorZpoolStatus zpools;
  monitorSshdDaemon = ''
    check process sshd with pidfile /var/run/sshd.pid
      start program "${pkgs.openssh}/bin/sshd start"
      stop program  "${pkgs.openssh}/bin/sshd stop"
      if failed port 22 protocol ssh then restart'';
in {
  services.monit.enable = true;
  services.monit.config = lib.strings.concatStringsSep "\n" [
    monitorGeneral
    monitorSystem
    monitorFilesystems
    monitorDriveTemperatures
    monitorDriveStatuses
    monitorZpoolStatuses
    monitorSshdDaemon
  ];
  networking.firewall.allowedTCPPorts =
    if openPort
    then [port]
    else [];
}
