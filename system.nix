{
  inputs,
  config,
  pkgs,
  username,
  hostname,
  host,
  ...
}:

let
  inherit (import ./nix-config/hosts/${host}/options.nix)
    theLocale
    theTimezone
    gitUsername
    theShell
    wallpaperDir
    wallpaperGit
    theLCVariables
    keyboardLayout
    consoleKeyMap
    flakePath
    theme
    ;
in
{
  imports = [
    ./nix-config/hosts/${host}/hardware.nix
    ./nix-config/system
    ./nix-config/users/users.nix
  ];

  # Set your time zone
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console.keyMap = "${consoleKeyMap}";

  environment.variables = {
    FLAKE = "${flakePath}";
    NIXOS_OZONE_WL = "1";
    #POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      #substituters = ["https://hyprland.cachix.org"];
      #trusted-public-keys = [
      #  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      #];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    #extraOptions = "!include ${config.sops.secrets.access-tokens.path}";
  };

  system.stateVersion = "23.11";
}
