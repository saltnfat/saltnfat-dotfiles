{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) syncthing username hostname;
in
lib.mkIf (syncthing == true) {
  systemd.user.services.syncthing = {
    wantedBy = lib.mkForce [ "graphical-session.target" ];
  };
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "${username}";
      dataDir = "/home/${username}"; # Default folder for new synced folders
      configDir = "/home/${username}/.config/syncthing"; # Folder for Syncthing's settings and keys
      key = config.sops.secrets."syncthing/${hostname}/key.pem".path;
      cert = config.sops.secrets."syncthing/${hostname}/cert.pem".path;
      settings = {
        devices = {
          "nix-deskstar" = {
            id = "M4RWYGV-U2V6EJH-LWBWLUD-XVVAXFA-6Y5ADCV-JQHJBWH-G5I5CK5-SZIFJQU";
          };
          "nix-lappy" = {
            id = "6ITFLW3-ATLKMCV-JILVSXF-HUE6EHU-XRDCVCR-HOH7SM3-4726KUQ-PTWMPAD";
          };
        };
        folders = {
          "Sync" = {
            path = "/home/${username}/Sync";
            devices = [
              "nix-deskstar"
              "nix-lappy"
            ];
          };
          "unsec-sync" = {
            path = "/home/${username}/unsec-sync";
            devices = [
              "nix-deskstar"
              "nix-lappy"
            ];
          };
          "Pictures" = {
            path = "/home/${username}/Pictures";
            devices = [
              "nix-deskstar"
              "nix-lappy"
            ];
          };
          "Music" = {
            path = "/home/${username}/Music";
            devices = [
              "nix-deskstar"
              "nix-lappy"
            ];
          };
        };
      };
    };
  };

  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  # these are opened on the firewall in networking.nix
}
