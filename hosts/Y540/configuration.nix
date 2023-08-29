{
  config,
  pkgs,
  inputs,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/users/filipe.nix
    (import ../../modules/options/terminal.nix)
    (import ../../modules/options/archive.nix)
    (import ../../modules/options/bluetooth.nix)
    (import ../../modules/options/browser.nix)
    (import ../../modules/options/communication.nix)
    (import ../../modules/options/tty.nix)
    (import ../../modules/options/editor.nix (args // {headless = false;}))
    (import ../../modules/options/file (args // {headless = false;}))
    (import ../../modules/options/fonts (args // {headless = false;}))
    (import ../../modules/options/gaming)
    (import ../../modules/options/gpg.nix)
    (import ../../modules/options/image.nix (args // {headless = false;}))
    (import ../../modules/options/kernel.nix)
    (import ../../modules/options/locale.nix)
    (import ../../modules/options/man.nix)
    (import ../../modules/options/memory.nix (args // {headless = false;}))
    (import ../../modules/options/monitoring.nix)
    (import ../../modules/options/multiplexer.nix)
    (import ../../modules/options/network.nix (args // {headless = false;}))
    (import ../../modules/options/nix.nix)
    (import ../../modules/options/nixtools.nix)
    (import ../../modules/options/nvidia.nix)
    (import ../../modules/options/onedrive.nix)
    (import ../../modules/options/other.nix)
    (import ../../modules/options/pdf.nix)
    (import ../../modules/options/power.nix)
    (import ../../modules/options/programming.nix)
    (import ../../modules/options/redshift.nix)
    (import ../../modules/options/scheduling.nix)
    (import ../../modules/options/shells.nix)
    (import ../../modules/options/ssh.nix)
    (import ../../modules/options/utils.nix)
    (import ../../modules/options/vcs.nix)
    (import ../../modules/options/media.nix (args // {headless = false;}))
    (import ../../modules/options/virtualisation.nix)
    (import ../../modules/options/word.nix)
    (import ../../modules/options/xserver)
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/home-manager/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  networking.hostName = "Y540";

  services = {
    xserver = {
      xkbOptions = "ctrl:swapcaps";
    };
    autorandr = {
      enable = true;
      profiles = {
        "default" = {
          fingerprint.eDP-1 = "00ffffffffffff0009e54d0800000000011c0104a522137802de50a3544c99260f5054000000010101010101010101010101010101019d8580a070383e406c30aa0058c11000001a000000000000000000000000000000000000000000fe00424f452048460a202020202020000000fe004e5631353646484d2d4e34470a0004";
          config.eDP-1 = {
            enable = true;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "144.00";
          };
        };
        "docked-gigabyte" = {
          fingerprint = {
            HDMI-1-0 = "00ffffffffffff001c540b2749020000151e0103803c22782a1c95a75549a2260f5054bfcf00d1c081c0814081809500b30001010101565e00a0a0a029503020350055502100001e59e7006aa0a067501520350055502100001e000000fd0030901ede3c000a202020202020000000fc0047323751430a2020202020202001340203477151010203111213901f044b4c05143f406061230917078301000067030c001000383c67d85dc401788803681a000001013090e6e305e001e40f008001e606070161561c5aa000a0a0a046503020350055502100001a6fc200a0a0a055503020350055502100001a282f005050a029500820b80455502100001a0000f5";
            eDP-1 = "00ffffffffffff0009e54d0800000000011c0104a522137802de50a3544c99260f5054000000010101010101010101010101010101019d8580a070383e406c30aa0058c11000001a000000000000000000000000000000000000000000fe00424f452048460a202020202020000000fe004e5631353646484d2d4e34470a0004";
          };
          config = {
            HDMI-1-0 = {
              enable = true;
              mode = "2560x1440";
              position = "0x0";
              primary = true;
              rate = "143.97";
            };
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              position = "2560x360";
              primary = false;
              rate = "144.00";
            };
          };
        };
        "docked-aorus" = {
          fingerprint = {
            HDMI-1-0 = "00ffffffffffff001c54062701010101221e0103803d2378ee11e5ae5044ac250d5054bfcf00d1c0714f81c0814081809500b3000101565e00a0a0a0295030203500544f2100001e000000fd0030901ede3c000a202020202020000000fc00414f5255532046493237510a20000000ff003230333430423030343837350a012c0203497153020311121304292f0e0f1d1e901f3f05146160230917078301000067030c002000383c67d85dc401788003681a000001013090ece305e301e40f000006e606070162620059e7006aa0a0675015203500544f2100001e6fc200a0a0a0555030203500544f2100001a977f8078703821401c203804544f2100001edf";
            eDP-1 = "00ffffffffffff0009e54d0800000000011c0104a522137802de50a3544c99260f5054000000010101010101010101010101010101019d8580a070383e406c30aa0058c11000001a000000000000000000000000000000000000000000fe00424f452048460a202020202020000000fe004e5631353646484d2d4e34470a0004";
          };
          config = {
            HDMI-1-0 = {
              enable = true;
              mode = "2560x1440";
              position = "1920x0";
              primary = true;
              rate = "143.97";
            };
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              position = "0x360";
              primary = false;
              rate = "144.00";
            };
          };
        };
      };
    };
  };
}
