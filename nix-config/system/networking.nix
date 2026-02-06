{
  host,
  inputs,
  config,
  ...
}:
let
  inherit (import ../hosts/${host}/options.nix) hostname;
in
{
  networking = {
    hostName = "${hostname}"; # Define your hostname
    networkmanager.enable = true;
    hosts = {
      "192.168.8.165" = [ "nix-lappy" ];
      "192.168.8.179" = [ "nix-deskstar" ];
    };
    nat = {
      enable = true;
      internalInterfaces = [ "virbr0" ];
    };
    firewall = {
      enable = false;
      allowedTCPPorts = [
        8384
        22000
        3000
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
      trustedInterfaces = [ "virbr0" ];
    };
  };
}
