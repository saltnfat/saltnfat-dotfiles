{
  pkgs,
  config,
  inputs,
  ...
}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.joypixels.acceptLicense = true;

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    #steam.gamescopeSession.enable = true;
    dconf.enable = true;
    seahorse.enable = false;
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    fuse.userAllowOther = true;
    # network diagnostic tool
    mtr.enable = true;
    hyprlock.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # List System Programs
  environment.systemPackages = with pkgs; [
    # X related packages
    xdo
    xdotool
    xorg.xprop
    xorg.xkill
    xorg.xdpyinfo
    xorg.xsetroot
    xorg.xwininfo
    xorg.xrandr

    # misc helpful utilities
    eza
    wget
    curl
    gitFull
    unzip
    unrar
    virt-viewer
    ripgrep
    fastfetch
    stow
    brightnessctl
    gparted
    kdePackages.partitionmanager
    sbctl # secure boot
    cmatrix # Matrix movie effect in terminal
    duf # disk usage util
    gpu-screen-recorder # noctalia-shell dep
    libnotify
    lm_sensors
    killall
    lshw # detailed Hardware info
    mdcat # CLI markdown parser
    mpv # vid player
    pandoc # format MD to HTML for cheatsheet parser
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    rhythmbox # audio player
    usbutils # Good Tools For USB Devices
    v4l-utils # Used For Things Like OBS Virtual Camera
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    wget # Tool For Fetching Files With Links
    ytmdl # Tool For Downloading Audio From YouTube
    sysfsutils # set of utilites built upon sysfs that exposes a system's device tree
    lact # gpu config tool (like msi afterburner)
    dnsmasq # for libvirt networking
    qemu_full
    sops
    ncdu # disk usage analyzer tui

    # Wayland / Hyprland
    egl-wayland # required for hyprland
    nwg-displays # configure monitor configs via GUI
    nwg-drawer # Application launcher for wayland
    nwg-dock-hyprland # Dock for hyprland
    nwg-menu # App menu for waybar
    waypaper # Change wallpaper

    # keyboard
    via
    vial
    qmk
    qmk-udev-rules
    qmk_hid

    # monitoring utils
    btop
    s-tui # stress tester
    iftop # network monitoring
    iotop # disk io monitoring
    nvtopPackages.full # gpu monitoring
    wireshark # packet monitoring
    clamav # antivirus

  ];
}
