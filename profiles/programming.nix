{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

  environment.systemPackages = with pkgs; [
    # Python and related packages
    (python3.withPackages (
      p: with p; [
        pip
        uv
        pyperclip
        pynvim
        pygments # For LaTeX
      ]
    ))
    poetry
    black
    pwntools


    # C/Cpp and related packages
    gcc
    gdb
    gf # gf2: Frontend for GDB
    gef
    inputs.pwndbg.packages.${stdenv.hostPlatform.system}.default
    indent
    valgrind
    ctags

    # C/Cpp build systems
    cmake
    ninja
    pkg-config
    meson
    autoconf
    automake
    libtool
    bison
    flex
    ccache

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
    yarn
    pnpm

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

    # Other build tools
    protobuf
    bazel

    # Documentation
    doxygen
    pandoc

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
