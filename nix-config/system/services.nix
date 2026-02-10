{
  pkgs,
  config,
  lib,
  inputs,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix)
    cpuType
    powerprofiles
    ;
in
{

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.keyboard.qmk.enable = true;

  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
    upower.enable = true; # noctalia shell battery
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More

    power-profiles-daemon = {
      enable = powerprofiles;
    };
    openssh = {
      enable = true; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; # Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [ 22 ];
    };
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    smartd = {
      enable = if cpuType == "vm" then false else true;
      autodetect = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
      };
    };
    udev = {
      packages = with pkgs; [
        qmk
        qmk-udev-rules
        qmk_hid
        via
        vial
      ];
      extraRules = ''
        # Let VIA see our keyboard
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4e45", ATTRS{idProduct}=="3635", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl" 

        # Disable wakeup triggers for all PCIe devices
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"

        # Disable usb xHCI controller from waking up pc on ASRock AM5 motherboards
        ACTION=="add", SUBSYSTEM=="pci", KERNEL=="0000:08:00.0", ATTR{power/wakeup}="disabled"

        # Disable Logitech Universal Receiver wakeup 
        ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c52b|c548|c547", ATTR{power/wakeup}="disabled"
      '';
    };

  };

}
