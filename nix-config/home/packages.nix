{
  pkgs,
  host,
  ...
}:

let
  vars = import ../hosts/${host}/options.nix;
  inherit (vars) barChoice;
  # Noctalia-specific packages
  noctaliaPkgs =
    if barChoice == "noctalia" then
      with pkgs;
      [
        matugen # color palette generator needed for noctalia-shell
        app2unit # launcher for noctalia-shell
        gpu-screen-recorder # needed for nnoctalia-shell
      ]
    else
      [ ];
in
{
  # Install Packages For The User
  home.packages =
    with pkgs;
    noctaliaPkgs
    ++ [
      ### unix porn related

      # Hyprland
      cliphist

      ## for bspwm rice:
      dunst
      bspwm
      dmenu
      sxhkd
      jq
      ranger
      picom
      ueberzug
      rofi
      tdrop
      eww
      jgmenu
      polybarFull
      polybar-pulseaudio-control

      # audio related
      libmpdclient
      playerctl
      mpd
      ncmpcpp
      mpc
      pamixer

      # dev related
      age
      alacritty
      kitty
      geany
      libvirt
      maim
      papirus-icon-theme
      joypixels
      zig
      gcc
      lazygit
      xclip
      zoxide
      fzf
      fd
      sesh
      docker
      mysql-workbench
      delta

      # zsh related
      zsh
      zsh-autosuggestions
      zsh-history-substring-search
      zsh-syntax-highlighting
      zsh-autocomplete

      # image related
      gdk-pixbuf
      webp-pixbuf-loader
      imagemagick
      libwebp
      feh
      gimp3-with-plugins
      inkscape-with-extensions

      # other
      betterlockscreen
      xscreensaver
      nh
      tldr
      tor-browser
      networkmanager_dmenu
      networkmanagerapplet
      thunderbird
      inetutils
      remmina
      keepassxc
      libreoffice
      evince # for pdfs
      nix-sweep # clean up nix profile generations and left over gc roots
      qtox
      qbittorrent
      tribler
      clamtk
      element-desktop

      # fonts
      cherry
      clarity-city
      cozette
      maple-mono.NF
      terminus_font
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.inconsolata
      nerd-fonts.jetbrains-mono
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.ubuntu-sans

      # Meh don't use
      #nerd-fonts.noto
      #nerd-fonts.recursive-mono

      # (nerdfonts.override {
      #   fonts = [
      #     "JetBrainsMono"
      #     "Terminus"
      #     "Inconsolata"
      #   ];
      # })
    ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh.enable = true;
  };
}
