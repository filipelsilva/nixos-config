{
  user,
  ...
}:
{
  imports = [
    ../../modules/user.nix
    ../../profiles/archive.nix
    ../../profiles/browser.nix
    ../../profiles/darkman.nix
    ../../profiles/editor.nix
    ../../profiles/file
    ../../profiles/fonts.nix
    ../../profiles/gpg.nix
    ../../profiles/homebrew.nix
    ../../profiles/image.nix
    ../../profiles/locale.nix
    ../../profiles/memory.nix
    ../../profiles/multiplexer.nix
    ../../profiles/nix.nix
    ../../profiles/nixtools.nix
    ../../profiles/onedrive.nix
    ../../profiles/onion.nix
    ../../profiles/pdf.nix
    ../../profiles/programming.nix
    ../../profiles/shells.nix
    ../../profiles/terminal.nix
    ../../profiles/utils.nix
    ../../profiles/vcs.nix
    ../../profiles/word.nix
    ./hardware-configuration.nix
  ];

  # Required by nix-darwin for user-scoped options (homebrew, system.defaults.*).
  system.primaryUser = user;

  # Use TouchID for sudo (closest analogue to profiles/fingerprint.nix).
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "clmv";
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  # FIXME: adapt keyboard layout tweaks to macOS (was ctrl:swapcaps on Linux).
  # system.keyboard.enableKeyMapping and carbon keyboards can set this.
  system.keyboard.enableKeyMapping = true;
}