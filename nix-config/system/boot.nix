{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix)
    secureboot
    nvmePowerFix
    pcieASPMDisable
    gpuType
    ;

  extraModprobeConfig =
    if gpuType == "nvidia" then
      ''
        blacklist nouveau
        blacklist nova_core
        options nouveau modeset=0
      ''
    else
      "";

  blacklistedKernelModules = if gpuType == "nvidia" then [ "nouveau" ] else [ ];
in
{

  # Bootloader
  boot.loader.systemd-boot = lib.mkMerge [
    (lib.mkIf (secureboot == true) {
      enable = lib.mkForce false;
    })
    (lib.mkIf (secureboot == false) {
      enable = true;
    })
  ];

  boot.lanzaboote = lib.mkIf (secureboot == true) {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
  };

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";

  # This is for OBS Virtual Cam Support - v4l2loopback setup
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  # Blacklist certain modules if using dedicated Nvidia gpu only
  boot.extraModprobeConfig = extraModprobeConfig;
  boot.blacklistedKernelModules = blacklistedKernelModules;

  boot.kernelParams = lib.mkMerge [
    (lib.mkIf (nvmePowerFix == true) [ "nvme_core.default_ps_max_latency_us=0" ])
    (lib.mkIf (pcieASPMDisable == true) [ "pcie_aspm=off" ])
    (lib.mkIf (pcieASPMDisable == true) [ "pcie_port_pm=off" ])
    #(lib.mkIf (pcieASPMDisable == true) [ "nvme.noacpi=1" ])
    #(lib.mkIf (gpuType == "nvidia") [ "mem_sleep_default=s2idle" ])
    (lib.mkIf (gpuType == "nvidia") [ "module_blacklist=amdgpu" ])
  ];
}
