{ inputs, pkgs, ... }:
let
  python-packages =
    ps: with ps; [
      pip
      pipx
      pyperclip
      pynvim
      pygments
    ];
in
{
  flake.modules.nixos.programs_programming =
    { inputs, pkgs, ... }:
    {
      programs = {
        java = {
          enable = true;
          package = pkgs.jdk;
        };
      };

      environment.systemPackages = with pkgs; [
        (python3.withPackages python-packages)
        black
        pwntools

        gcc
        gdb
        gf
        gef
        inputs.pwndbg.packages.${stdenv.hostPlatform.system}.default
        indent
        valgrind
        ctags

        jdk11
        jdk8
        google-java-format
        maven

        go

        lua

        rust-bin.stable.latest.default

        ruby

        nodejs

        perl

        jq

        pup

        shellcheck
        shellharden

        gnumake

        cloc
        tokei

        time
        hyperfine
        strace
        rr
        ltrace
        perf-tools
        cargo-flamegraph
        frida-tools
      ];
    };
}
