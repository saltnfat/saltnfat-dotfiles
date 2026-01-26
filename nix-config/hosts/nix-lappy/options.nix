# Easy user options config file to help obviate the need for configuring common user differences in other .nix files

let
  setUsername = "non";
  setHostname = "nix-lappy";
in
{

  #inherit username hostname userHome flakeDir;
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";
  flakePath = "/home/${setUsername}/jwy-gh0stzk-dotfiles";
  wallpaperDir = "/home/${setUsername}/Pictures/Wallpapers";
  screenshotDir = "/home/${setUsername}/Pictures/Screenshots";

  # User Variables
  gitUsername = "jwy";
  gitEmail = "jwingy@gmail.com";

  # System Settings
  theLocale = "en_US.UTF-8";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/New_York";
  keyboardLayout = "us";
  keyboardVariant = "";
  consoleKeyMap = "us";

  # Set Display Manager
  # `tui` for Text login
  # `sddm` for graphical GUI (default)
  displayManager = "sddm";

  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "latest"; # Possible options: default, latest, lqx, xanmod, zen

  cpuType = "amd";
  #gpuType = "nvidia";
  gpuType = "amd";

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS!
  amd-bus-id = "";
  nvidia-bus-id = "";

  # Only if you set up an encrypted swap partition with LUKS
  # can find the part uuid using the command lsblk -no PARTUUID <device id e.g. /dev/nvme1n1p9>
  swapPartUUID = "";
  swapLUKSID = "";

  # DE / WM
  bspwm = true;
  kde = false;

  # Base16 Theme
  theme = "catppuccin-mocha";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Program options
  distrobox = false;
  flatpak = false;
  kdenlive = false;
  blender = false;

  # Enable Support For
  # Logitech Devices
  logitech = true;

  # Enable Terminals
  # If You Disable All You Get Kitty
  wezterm = true;
  alacritty = true;
  kitty = false;

  # Enable Python & PyCharm
  python = false;

  # Enable SyncThing
  syncthing = true;

  # Xorg scaling
  x11ScaleFactor = "1.4";
  xrandrScale = "0.8x0.8";

  # Power profiles daemon
  powerprofiles = true;

  # Use lanzaboote for secureboot
  secureboot = true;

  # NVME ssd acpi power management workaround
  nvmePowerFix = false;
  pcieASPMDisable = false;

  # For burn in protection on OLED
  oled = true;

  # Install gaming packages and features
  gamingEnable = false;

  #### Hyprland / Wayland #######

  # Choose between noctalia or waybar
  barChoice = "noctalia";

  # Waybar Settings (used when barChoice = "waybar")
  clock24h = false;

  # Program Options
  # Set Default Browser (google-chrome-stable for google-chrome)
  # This does NOT install your browser
  # You need to install it by adding it to the `packages.nix`
  # or as a flatpak
  browser = "firefox";

  # Available Options:
  # Kitty, ghostty, wezterm, aalacrity
  # Note: kitty, wezterm, alacritty have to be enabled in `variables.nix`
  # Setting it here does not enable it. Kitty is installed by default
  terminal = "alacritty"; # Set Default System Terminal

  # Examples:
  # extraMonitorSettings = "monitor = Virtual-1,1920x1080@60,auto,1";
  # extraMonitorSettings = "monitor = HDMI-A-1,1920x1080@60,auto,1";
  # You can configure multiple monitors.
  # Inside the quotes, create a new line for each monitor.
  extraMonitorSettings = "

    ";

  # Themes, waybar and animation.
  # Only uncomment your selection - The others much be commented out.

  # Set Stylix Image
  # This will set your color palette
  # Default background
  # Add new images to ~/zaneyos/wallpapers
  stylixImage = ../../../wallpapers/mountainscapedark.jpg;
  #stylixImage = ../../../wallpapers/AnimeGirlNightSky.jpg;
  #stylixImage = ../../../wallpapers/Anime-Purple-eyes.png;
  #stylixImage = ../../../wallpapers/Rainnight.jpg;
  #stylixImage = ../../../wallpapers/zaney-wallpaper.jpg;
  #stylixImage = ../../../wallpapers/nix-wallpaper-stripes-logo.png;
  #stylixImage = ../../../wallpapers/beautifulmountainscape.jpg;

  # Set Waybar
  #  Available Options:
  waybarChoice = ../../home/waybar/waybar-curved.nix;

  # Set Animation style
  # Available options are:
  animChoice = ../../home/hyprland/animations/animations-def.nix;
  #animChoice = ../../modules/home/hyprland/animations-end4.nix;
  #animChoice = ../../modules/home/hyprland/animations-end4-slide.nix;
  #animChoice = ../../modules/home/hyprland/animations-end-slide.nix;
  #animChoice = ../../modules/home/hyprland/animations-dynamic.nix;
  #animChoice = ../../modules/home/hyprland/animations-moving.nix;
  #animChoice = ../../modules/home/hyprland/animations-hyde-optimized.nix;
  #animChoice = ../../modules/home/hyprland/animations-mahaveer-me-1.nix;
  #animChoice = ../../modules/home/hyprland/animations-mahaveer-me-2.nix;
  #animChoice = ../../modules/home/hyprland/animations-ml4w-classic.nix;
  #animChoice = ../../modules/home/hyprland/animations-ml4w-fast.nix;
  #animChoice = ../../modules/home/hyprland/animations-ml4w-high.nix;
}
