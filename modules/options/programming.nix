{
  config,
  pkgs,
  inputs,
  ...
}: let
  python-packages = ps:
    with ps; [
      pyperclip
      pynvim
    ];
in {
  programs = {
    java.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Python and related packages
    (python3Full.withPackages python-packages)
    pypy3
    black
    pwntools
    sage
    z3

    # C/Cpp and related packages
    gcc
    gdb
    gef
    pwndbg
    indent
    valgrind
    ctags

    # Java
    jdk
    jdk11
    jdk8
    maven

    # Go
    go

    # Lua
    lua

    # Rust
    rustup
    rustc
    cargo

    # Ruby
    ruby

    # JavaScript
    nodejs

    # Perl
    perl

    # JSON
    jq
    jc

    # HTML
    pup

    # Shell script static analysis
    shellcheck

    # Auto builder
    gnumake
    cmake

    # Code counter
    cloc
    tokei

    # Profile and benchmark programs
    time
    hyperfine
    strace
    rr
    lurk
    ltrace
    perf-tools
    cargo-flamegraph
  ];
}
