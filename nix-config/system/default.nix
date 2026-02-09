{
  inputs,
  host,
  ...
}:
let
  # Import the host-specific options.nix
  vars = import ../hosts/${host}/options.nix;
  inherit (vars)
    gamingEnable
    ;
in
{

  imports = [
    # Conditionally import the display manager module
    (if vars.displayManager == "tui" then ./ly.nix else ./sddm.nix)
    ./amd-gpu.nix
    ./appimages.nix
    ./autorun.nix
    ./boot.nix
    ./bspwm.nix
    ./dev-mode.nix
    ./kde.nix
    ./hwclock.nix
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./kernel.nix
    ./lact.nix
    ./logitech.nix
    ./maccel.nix
    ./networking.nix
    ./ntp.nix
    ./nvidia.nix
    ./opengl.nix
    ./packages.nix
    ./quickshell.nix
    ./security.nix
    ./services.nix
    ./sops.nix
    ./stylix.nix
    ./swap.nix
    ./syncthing.nix
    ./thunar.nix
    ./virtualisation.nix
    ./vm.nix
    ./xorgScale.nix

    inputs.stylix.nixosModules.stylix
  ]
  ++ (if gamingEnable then [ ./gaming.nix ] else [ ])

  ;
}
