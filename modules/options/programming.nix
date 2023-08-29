{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      pip
      pipx
      pyperclip
      pynvim
      latexify-py
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
    pypy3
    black
    pwntools

    # C/Cpp and related packages
    gcc
    gdb
    gef
    pwndbg
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

    # Julia
    julia-bin

    # Perl
    perl

    # JSON
    jq

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
    frida-tools
  ];
}
