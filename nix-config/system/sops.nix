{ host, inputs, ... }:
let
  inherit (import ../hosts/${host}/options.nix) username flakePath;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  #sops.secrets.ssh.general = { };
  #sops.secrets.ssh.general_pub = { };
  #sops.secrets.home_wifi_ssid = { };
  #sops.secrets.home_wifi_pw = { };
  sops.secrets."syncthing/cert.pem" = {
    owner = "${username}";
    mode = "0600";

  };
  sops.secrets."syncthing/key.pem" = {
    owner = "${username}";
    mode = "0600";
  };
  sops.secrets.git = { };
}
