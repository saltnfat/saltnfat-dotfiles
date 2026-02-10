{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  palette = config.colorScheme.palette;
  inherit (import ../hosts/${host}/options.nix) alacritty x11ScaleFactor;
in
lib.mkIf (alacritty == true) {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        # import = [
        #   "~/.config/alacritty/rice-colors.toml"
        #   "~/.config/alacritty/fonts.toml"
        # ];
        live_config_reload = true;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        blink_interval = 550;
        unfocused_hollow = false;
        thickness = 0.15;
      };
      env = {
        WINIT_X11_SCALE_FACTOR = x11ScaleFactor;
        TERM = "xterm-256color";
      };
      keyboard.bindings = [
        {
          key = "Key0";
          mods = "Control";
          chars = "\\u001b[48;5u";
        }
        {
          key = "Key1";
          mods = "Control";
          chars = "\\u001b[49;5u";
        }
        {
          key = "Key2";
          mods = "Control";
          chars = "\\u001b[50;5u";
        }
        {
          key = "Key3";
          mods = "Control";
          chars = "\\u001b[51;5u";
        }
        {
          key = "Key4";
          mods = "Control";
          chars = "\\u001b[52;5u";
        }
        {
          key = "Key5";
          mods = "Control";
          chars = "\\u001b[53;5u";
        }
        {
          key = "Key6";
          mods = "Control";
          chars = "\\u001b[54;5u";
        }
        {
          key = "Key7";
          mods = "Control";
          chars = "\\u001b[55;5u";
        }
        {
          key = "Key8";
          mods = "Control";
          chars = "\\u001b[56;5u";
        }
        {
          key = "Key9";
          mods = "Control";
          chars = "\\u001b[57;5u";
        }
        {
          key = "Comma";
          mods = "Control";
          chars = "\x1b[44;5u";
        }
        {
          key = "Period";
          mods = "Control";
          chars = "\x1b[46;5u";
        }
      ];
      selection = {
        save_to_clipboard = true;
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      window = {
        decorations = "none";
        dynamic_title = true;
        dynamic_padding = true;
        padding.x = 5;
        padding.y = 5;
        opacity = 1.0;
      };
    };
  };
}
