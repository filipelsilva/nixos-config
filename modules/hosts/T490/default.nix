{ inputs, ... }@top:
{
  flake.modules.nixos.host_T490 =
    { config, pkgs, ... }:
    {
      imports = with top.config.flake.modules.nixos; [
        core_base
        core_nix
        core_locale
        core_location
        core_network
        core_shells
        core_kernel
        core_utils
        core_man
        core_memory
        core_multiplexer
        core_scheduling
        core_tty
        core_nixtools
        core_archive
        hardware_intel
        hardware_fingerprint
        hardware_firmware
        hardware_power
        desktop_audio
        desktop_browser
        desktop_communication
        desktop_darkman
        desktop_fonts
        desktop_terminal
        desktop_wayland
        desktop_bluetooth
        programs_editor
        programs_programming
        programs_vcs
        programs_image
        programs_word
        programs_pdf
        programs_media
        programs_archive
        programs_file-headless
        programs_file-graphical
        programs_package-managers
        programs_onedrive
        programs_gpg
        services_wireguard
        services_ssh
        services_fail2ban
        services_onion
        gaming_base
        gaming_steam
        gaming_lutris
        gaming_heroic
        gaming_minecraft
        gaming_wine
        virtualisation_docker
        virtualisation_libvirt
        virtualisation_vagrant
        virtualisation_winapps
      ];

      custom.headless = false;

      boot = {
        kernelParams = [ "snd-intel-dspcfg.dsp_driver=1" ];
        kernelModules = [ "snd_hda_intel" ];
        loader = {
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
          grub = {
            enable = true;
            efiSupport = true;
            useOSProber = true;
            device = "nodev";
          };
        };
      };

      modules.wireguard = {
        enable = true;
        type = "client";
        lastOctet = 3;
      };

      environment.etc."sway/config.d/keyboard.conf".text = ''
        input "*" xkb_options ctrl:swapcaps
      '';
    };
}
