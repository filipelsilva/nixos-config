# Dominik Schrempf: https://dschrempf.github.io/linux/2024-02-14-monitoring-a-home-server/
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) strings mkEnableOption mkOption;

  cfg = config.modules.monitoring;

  port = 2812;
  cpuTemp = cpuTempFile:
    pkgs.writeShellScript "cpu-temp" ''
      cat ${cpuTempFile} | sed 's/\(.\)..$/.\1°C/'
    '';
  hdTemp = pkgs.writeShellScript "hd-temp" ''
    SMARTCTL_OUTPUT=$(${pkgs.smartmontools}/bin/smartctl --json=c --nocheck=standby -A "$1")
    if [[ "$?" = "2" ]]; then
        echo "STANDBY"
        exit 0
    fi
    TEMPERATURE=$(${pkgs.jq}/bin/jq '.temperature.current' <<< "$SMARTCTL_OUTPUT")
    echo "$TEMPERATURE"°C
    exit "$TEMPERATURE"
  '';
  hdStatus = pkgs.writeShellScript "hd-status" ''
    SMARTCTL_OUTPUT=$(${pkgs.smartmontools}/bin/smartctl --json=c --nocheck=standby -H "$1")
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
  monitorGeneral = allowedIps: ''
    set daemon 60
    set logfile /var/log/monit.log
    set httpd port ${builtins.toString port}
       allow localhost ${strings.concatMapStringsSep " " (ip: "allow " + ip) allowedIps}'';
  monitorSystem = ''
    check system $HOST
      if loadavg (15min) > 5 for 5 times within 15 cycles then alert
      if memory usage > 80% for 4 cycles then alert
      if swap usage > 20% for 4 cycles then alert'';
  monitorCpuTemperature = cpuTempFile: ''
    check program "cpu temperature" with path "${cpuTemp cpuTempFile}"
      if status > 45 then alert
      group health'';
  monitorFilesystem = fs: ''
    check filesystem "path ${fs}" with path ${fs}
      if space usage > 90% then alert'';
  monitorFilesystems = filesystems: strings.concatMapStringsSep "\n" monitorFilesystem filesystems;
  monitorDriveTemperature = drive: ''
    check program "drive temperature: ${drive}" with path "${hdTemp} ${drive}"
      every "0,30 * * * *"
      if status > 40 then alert
      group health'';
  monitorDriveTemperatures = drives: strings.concatMapStringsSep "\n" monitorDriveTemperature drives;
  monitorDriveStatus = drive: ''
    check program "drive status: ${drive}" with path "${hdStatus} ${drive}"
      every "0 0,12 * * *"
      if status > 0 then alert
      group health'';
  monitorDriveStatuses = drives: strings.concatMapStringsSep "\n" monitorDriveStatus drives;
  monitorZpoolStatus = zpool: ''
    check program "zpool status: ${zpool}" with path "${pkgs.zfs}/bin/zpool status ${zpool}"
      if content != "state: ONLINE" then alert
      group heatlh'';
  monitorZpoolStatuses = zpools: strings.concatMapStringsSep "\n" monitorZpoolStatus zpools;
  monitorSshdDaemon = ''
    check process sshd with pidfile /var/run/sshd.pid
      start program "${pkgs.openssh}/bin/sshd start"
      stop program  "${pkgs.openssh}/bin/sshd stop"
      if failed port 22 protocol ssh then restart'';
in {
  options.modules.monitoring = {
    enable = mkEnableOption "monitoring";

    cpuTempFile = mkOption {
      type = types.str;
      example = "/sys/class/thermal/thermal_zone1/temp";
      description = "Path to the CPU temperature file.";
    };
    filesystems = mkOption {
      type = types.listOf types.str;
      example = ''
        ["/"]
      '';
      description = "List of monitored file system paths.";
    };
    drives = mkOption {
      type = types.listOf types.str;
      example = ''
        [
          "/dev/disk/by-id/..."
          ...
        ]
      '';
      description = "List of monitored drives.";
    };
    zpools = mkOption {
      type = types.listOf types.str;
      example = ''["data"]'';
      description = "List of monitored ZFS pools.";
    };
    allowedIps = mkOption {
      type = types.listOf types.str;
      description = "Allow access from these IP addresses.";
    };
    port = mkOption {
      type = types.int;
      default = port;
      description = "Monit TCP port.";
    };
    openPort = mkOption {
      type = types.bool;
      description = "Open Monit TCP port in firewall.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.cpuTempFile != null;
        message = "The option `modules.monitoring.cpuTempFile is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.filesystems != null;
        message = "The option `modules.monitoring.filesystems is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.drives != null;
        message = "The option `modules.monitoring.drives is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.zpools != null;
        message = "The option `modules.monitoring.zpools is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.allowedIps != null;
        message = "The option `modules.monitoring.allowedIps is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.port != null;
        message = "The option `modules.monitoring.port is required when `modules.monitoring.enable` is true.";
      }
      {
        assertion = cfg.openPort != null;
        message = "The option `modules.monitoring.openPort is required when `modules.monitoring.enable` is true.";
      }
    ];
    services.monit.enable = true;
    services.monit.config = strings.concatStringsSep "\n" [
      (monitorGeneral cfg.allowedIps)
      monitorSystem
      (monitorCpuTemperature cfg.cpuTempFile)
      (monitorFilesystems cfg.filesystems)
      (monitorDriveTemperatures cfg.drives)
      (monitorDriveStatuses cfg.drives)
      (monitorZpoolStatuses cfg.zpools)
      monitorSshdDaemon
    ];
    networking.firewall.allowedTCPPorts =
      if cfg.openPort
      then [cfg.port]
      else [];
  };
}
