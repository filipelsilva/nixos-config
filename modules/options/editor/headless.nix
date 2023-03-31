{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ed
    gnused
    sd
    vimHugeX # TODO check options
    bvi
    bless # Hex editor

    # Pagers
    less
    lesspipe
    bat
    hexyl

    # Finders
    fzf
    fd
    silver-searcher
    pdfgrep
    ripgrep
    ripgrep-all
    plocate

    # Run commands when files change
    entr
    watchexec
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.rsyncd.enable = true;
}
# VIM - Vi IMproved 9.0 (2022 Jun 28, compiled Mar 21 2023 20:51:42)
# Included patches: 1-1420
# Compiled by Arch Linux
# Huge version with GTK3 GUI.  Features included (+) or not (-):
# +acl               +file_in_path      +mouse_urxvt       -tag_any_white
# +arabic            +find_in_path      +mouse_xterm       +tcl/dyn
# +autocmd           +float             +multi_byte        +termguicolors
# +autochdir         +folding           +multi_lang        +terminal
# -autoservername    -footer            -mzscheme          +terminfo
# +balloon_eval      +fork()            +netbeans_intg     +termresponse
# +balloon_eval_term +gettext           +num64             +textobjects
# +browse            -hangul_input      +packages          +textprop
# ++builtin_terms    +iconv             +path_extra        +timers
# +byte_offset       +insert_expand     +perl/dyn          +title
# +channel           +ipv6              +persistent_undo   +toolbar
# +cindent           +job               +popupwin          +user_commands
# +clientserver      +jumplist          +postscript        +vartabs
# +clipboard         +keymap            +printer           +vertsplit
# +cmdline_compl     +lambda            +profile           +vim9script
# +cmdline_hist      +langmap           -python            +viminfo
# +cmdline_info      +libcall           +python3/dyn       +virtualedit
# +comments          +linebreak         +quickfix          +visual
# +conceal           +lispindent        +reltime           +visualextra
# +cryptv            +listcmds          +rightleft         +vreplace
# +cscope            +localmap          +ruby/dyn          +wildignore
# +cursorbind        +lua/dyn           +scrollbind        +wildmenu
# +cursorshape       +menu              +signs             +windows
# +dialog_con_gui    +mksession         +smartindent       +writebackup
# +diff              +modify_fname      -sodium            +X11
# +digraphs          +mouse             +sound             -xfontset
# +dnd               +mouseshape        +spell             +xim
# -ebcdic            +mouse_dec         +startuptime       -xpm
# +emacs_tags        +mouse_gpm         +statusline        +xsmp_interact
# +eval              -mouse_jsbterm     -sun_workshop      +xterm_clipboard
# +ex_extra          +mouse_netterm     +syntax            -xterm_save
# +extra_search      +mouse_sgr         +tag_binary
# -farsi             -mouse_sysmouse    -tag_old_static
#    system vimrc file: "/etc/vimrc"
#      user vimrc file: "$HOME/.vimrc"
#  2nd user vimrc file: "~/.vim/vimrc"
#       user exrc file: "$HOME/.exrc"
#   system gvimrc file: "/etc/gvimrc"
#     user gvimrc file: "$HOME/.gvimrc"
# 2nd user gvimrc file: "~/.vim/gvimrc"
#        defaults file: "$VIMRUNTIME/defaults.vim"
#     system menu file: "$VIMRUNTIME/menu.vim"
#   fall-back for $VIM: "/usr/share/vim"
# Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/sysprof-4 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/gio-unix-2.0 -I/usr/include/cloudproviders -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -pthread -march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -g -ffile-prefix-map=/build/vim/src=/usr/src/debug/vim -flto=auto -D_REENTRANT -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
# Linking: gcc -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.36/core_perl/CORE -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -flto=auto -L/usr/local/lib -o vim -lgtk-3 -lgdk-3 -lz -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lSM -lICE -lXt -lX11 -lXdmcp -lSM -lICE -lm -ltinfo -lelf -lcanberra -lacl -lattr -lgpm -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.36/core_perl/CORE -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -flto=auto -fstack-protector-strong -L/usr/local/lib -L/usr/lib/perl5/5.36/core_perl/CORE -lperl -lpthread -ldl -lm -lcrypt -lutil -lc -L/usr/lib -ltclstub8.6 -ldl -lz -lpthread -lm

