{
  pkgs,
  inputs,
  ...
}: let
  python-packages = ps:
    with ps; [
      pip
      pipx
      pyperclip
      pynvim
      pygments # For LaTeX
    ];
in {
  programs = {
    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

  environment.systemPackages = with pkgs; [
    # Python and related packages
    (python3Full.withPackages python-packages)
    black
    pwntools

    # C/Cpp and related packages
    gcc
    gdb
    gef
    inputs.pwndbg.packages.${system}.default
    indent
    valgrind
    ctags

    # Java
    jdk11
    jdk8
    google-java-format
    maven

    # Go
    go

    # Lua
    lua

    # Rust
    rust-bin.stable.latest.default

    # Ruby
    ruby

    # JavaScript
    nodejs

    # Perl
    perl

    # JSON
    jq

    # HTML
    pup

    # Shell script static analysis
    shellcheck
    shellharden

    # Auto builder
    gnumake

    # Code counter
    cloc
    tokei

    # Profile and benchmark programs
    time
    hyperfine
    strace
    rr
    ltrace
    perf-tools
    cargo-flamegraph
    frida-tools
  ];
}
