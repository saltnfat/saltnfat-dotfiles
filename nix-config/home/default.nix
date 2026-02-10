{ host, ... }:
let
  vars = import ../hosts/${host}/options.nix;
  inherit (vars)
    barChoice
    waybarChoice
    gamingEnable
    ;
  # Select bar module based on barChoice
  barModule =
    if barChoice == "noctalia" then
      ./noctalia.nix
    else if barChoice == "dms" then
      ./dms.nix
    else
      waybarChoice;
in
{

  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    barModule
    ./firefox.nix
    ./git.nix
    ./gtk.nix
    ./hyprland
    ./mangohud.nix
    ./mpd.nix
    ./neovim.nix
    ./overview.nix
    ./packages.nix
    ./python.nix
    ./qt.nix
    ./rofi
    ./scripts
    ./starship.nix
    ./stylix.nix
    ./swaync.nix
    ./tmux.nix
    ./virtmanager.nix
    ./wlogout
    ./xdg.nix
    #./yazi.nix # TODO: currently broken. May need to refactor the way user is created
    ./zen-browser.nix
    ./zoxide.nix
    ./zsh.nix

    # Place home and dot files like Pictures
    ./files.nix
  ]
  ++ (if gamingEnable then [ ./games.nix ] else [ ]);
}
