{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [

    # Calculators
    bc
    libqalculate
    octaveFull

    # Finders
    fzf
    fd
    silver-searcher
    pdfgrep
    ripgrep
    ripgrep-all

    # Information fetchers
    neofetch
    onefetch

    # Run commands when files change
    entr
    watchexec

    # Virtualisation
    docker
    docker-compose
    libvirt
    virt-manager
    virtualbox
    vagrant

    # Other packages
    file # Get type of file
    plocate # Find filenames quickly
    ctop # Top for containers
    parallel # Xargs alternative
    gping # Ping, but with a graph
    rlwrap # Readline wrapper
    bat # Cat with syntax highlighting
    hexyl # Hex viewer
    tealdeer # Cheat sheet for common programs
    ascii # Show character codes
    haskellPackages.words # Populate /usr/share/dict with list of words
    datamash # Manipulate data in textual format
    lnav # Logfile Navigator
    zoxide # Autojump to recent folders
    tree # List files in tree format
    pipe-rename # Rename files in your $EDITOR
    rename # Rename files using Perl regex
    openssh # SSH programs
    zbar # Bar code reader
    qrencode # Generate QR codes
    pup # Like jq, but for HTML (parsing)
    cht-sh # Cheat sheet
    rar # Archive management
    mprocs # Run multiple commands in parallel
    rr # Record process to debug
    lurk # Alternative to strace

    xkeyboard_config # TODO check if this works with useXkbConfig
  ];
}
