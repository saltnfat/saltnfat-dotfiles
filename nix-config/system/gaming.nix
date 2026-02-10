{ config, pkgs, ... }:

{
  ####################
  # Gaming Packages  #
  ####################
  environment.systemPackages = with pkgs; [
    # Launchers
    heroic
    # lutris (optional)

    # Emulators
    retroarch-full

    # Steam / Proton helpers
    protonup-qt
    protontricks
    cabextract # dependency for Winetricks/Protontricks

    # Graphics | Vulkan/Direct3D translation for Proton / Wine / games
    dxvk
    vkd3d

    # Wine & helpers
    wineWowPackages.full
    winetricks
    faudio

    # Performance tools
    gamemode
    #mangohud
    gamescope
  ];

  ####################
  # Environment Vars #
  ####################
  environment.sessionVariables = {
    # Default 64-bit Wine prefix for modern games
    WINEPREFIX = "$HOME/.wine";
    WINEARCH = "win64";

    # Vulkan / gaming tweaks
    MANGOHUD = "1";
    OBS_VKCAPTURE = "1";
    RADV_TEX_ANISO = "16";

    # Explicit Wine paths for Winetricks / Protontricks (avoids unknown arch)
    WINE = "/run/current-system/sw/bin/wine";
    WINESERVER = "/run/current-system/sw/bin/wineserver";
  };

  ####################
  # Steam Setup      #
  ####################
  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
    extest.enable = true; # Wayland support

    # Optional Steam features
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;

    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = "1";
        USEMANGOHUD = "1";
        OBS_VKCAPTURE = "1";
        RADV_TEX_ANISO = "16";
      };
    };

    extraPackages = with pkgs; [
      gamescope
      mangohud
      gamemode
    ];

    extraCompatPackages = with pkgs; [
      #steamtinkerlaunch # Proton configuration tool
      proton-ge-bin
    ];
  };

  ####################
  # Gamemode Config  #
  ####################
  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    args = [
      "--adaptive-sync"
      "--hdr-enabled"
      "--mangoapp"
      "--rt"
      "--steam"
      "--expose-wayland"
    ];

  };
}
