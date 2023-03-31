{
  config,
  pkgs,
  inputs,
  ...
}: let
  python-packages = ps:
    with ps; [
      pip # TODO this won't work probably
      pyperclip
      pynvim
      capstone
      black
      pwntools
      keystone-engine
      z3
    ];
in {
  environment.systemPackages = with pkgs; [
    # Python and related packages (some of them used for gdb/gef/pwndbg)
    (python3Full.withPackages python-packages)
    pypy3
    python2Full
    pypy
    sage

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
