{ host, ... }:
let
  inherit (import ../../hosts/${host}/options.nix)
    extraMonitorSettings
    ;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        #"noblur, xwayland:1" # Helps prevent odd borders/shadows for xwayland apps
        # downside it can impact other xwayland apps
        # This rule is a template for a more targeted approach
        "tag +file-manager, match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "tag +terminal, match:class ^(com.mitchellh.ghostty|org.wezfurlong.wezterm|Alacritty|kitty|kitty-dropterm)$"
        "tag +browser, match:class ^(Brave-browser(-beta|-dev|-unstable)?)$"
        "tag +browser, match:class ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
        "tag +browser, match:class ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
        "tag +browser, match:class ^([Tt]horium-browser|[Cc]achy-browser)$"
        "tag +browser, match:class ^([Zz]en-beta|[Zz]en-browser)$"
        "tag +projects, match:class ^(codium|codium-url-handler|VSCodium)$"
        "tag +projects, match:class ^(VSCode|code-url-handler)$"
        "tag +im, match:class ^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
        "tag +im, center on, float on, size (monitor_w*0.6) (monitor_h*0.7), match:class ^([Ff]erdium)$"
        "tag +im, match:class ^([Ww]hatsapp-for-linux)$"
        "tag +im, match:class ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
        "tag +im, match:class ^(teams-for-linux)$"
        "tag +games, match:class ^(gamescope)$"
        "tag +games, match:class ^(steam_app_d+)$"
        "tag +games, match:class ^(com.libretro.RetroArch|[Rr]etro[Aa]rch)$"
        "tag +gamestore, match:class ^([Ss]team)$"
        "tag +gamestore, match:title ^([Ll]utris)$"
        "tag +gamestore, match:class ^(com.heroicgameslauncher.hgl)$"
        "tag +settings, match:class ^(gnome-disks|wihotspot(-gui)?)$"
        "tag +settings, match:class ^([Rr]ofi)$"
        "tag +settings, match:class ^(file-roller|org.gnome.FileRoller)$"
        "tag +settings, match:class ^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +settings, center on, match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +settings, match:class ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "tag +settings, match:class (xdg-desktop-portal-gtk)"
        "tag +settings, match:class (.blueman-manager-wrapped)"
        "tag +settings, match:class (nwg-displays)"
        "move ((monitor_w*0.72)) ((monitor_h*0.07)), float on, opacity 0.95 0.75, pin on, keep_aspect_ratio on, match:title ^(Picture-in-Picture)$"
        "float on, center on, size (monitor_w*0.55) (monitor_h*0.66), match:title ^(Hyprland Keybinds|Emacs Leader Keybinds|Kitty Configuration|WezTerm Configuration|Ghostty Configuration|Yazi Configuration)$"
        "float on, center on, size (monitor_w*0.65) (monitor_h*0.6), match:title ^(Cheatsheets Viewer)$"
        "float on, match:class ^([Ww]aypaper)$"
        "float on, match:class ^(org\.qt-project\.qml)$, match:title ^(Wallpapers)$"
        "float on, center on, match:class ^(org\.qt-project\.qml)$, match:title ^(Video Wallpapers)$"
        "float on, center on, match:class ^(org\.qt-project\.qml)$, match:title ^(qs-wlogout)$"
        "float on, center on, no_shadow on, no_blur on, rounding 12, match:class ^(org\.qt-project\.qml)$, match:title ^(Panels)$"
        "float on, center on, size (monitor_w*0.55) (monitor_h*0.66), match:title ^(Hyprland Keybinds|Niri Keybinds|BSPWM Keybinds|i3 Keybinds|Sway Keybinds|DWM Keybinds|Emacs Leader Keybinds|Kitty Configuration|WezTerm Configuration|Ghostty Configuration|Yazi Configuration|Cheatsheets Viewer|Documentation Viewer)$"
        "center on, float on, match:class ([Tt]hunar), match:title negative:(.*[Tt]hunar.*)"
        "center on, float on, match:title ^(Authentication Required)$"
        "idle_inhibit fullscreen, match:class ^(*)$"
        "idle_inhibit fullscreen, match:title ^(*)$"
        "idle_inhibit fullscreen, match:fullscreen 1"
        "float on, size (monitor_w*0.7) (monitor_h*0.7), opacity 0.8 0.7, match:tag settings*"
        "float on, match:class ^(mpv|com.github.rafostar.Clapper)$"
        "float on, match:class (codium|codium-url-handler|VSCodium), match:title negative:(.*codium.*|.*VSCodium.*)"
        "float on, match:class ^(com.heroicgameslauncher.hgl)$, match:title negative:(Heroic Games Launcher)"
        "float on, match:class ^([Ss]team)$, match:title negative:^([Ss]team)$"
        "float on, size (monitor_w*0.7) (monitor_h*0.6), match:initial_title (Add Folder to Workspace)"
        "float on, size (monitor_w*0.7) (monitor_h*0.6), match:initial_title (Open Files)"
        "float on, match:initial_title (wants to save)"
        "opacity 1.0 0.85, match:tag browser*"
        "opacity 0.9 0.8, match:tag projects*"
        "opacity 0.94 0.86, match:tag im*"
        "opacity 0.9 0.8, match:tag file-manager*"
        "opacity 0.9 0.7, match:tag terminal*"
        "opacity 0.8 0.7, match:class ^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9 0.8, match:class ^(seahorse)$ # gnome-keyring gui"
        "no_blur on, fullscreen on, match:tag games*"

      ];

      windowrulev2 = [
        # qs-wallpapers styling via compositor
        "noborder, class:^(org\\.qt-project\\.qml)$, title:^(Wallpapers)$"
        "noshadow, class:^(org\\.qt-project\\.qml)$, title:^(Wallpapers)$"
        "noblur, class:^(org\\.qt-project\\.qml)$, title:^(Wallpapers)$"
        "rounding 12, class:^(org\\.qt-project\\.qml)$, title:^(Wallpapers)$"

        # qs-vid-wallpapers styling via compositor
        "noborder, class:^(org\\.qt-project\\.qml)$, title:^(Video Wallpapers)$"
        "noshadow, class:^(org\\.qt-project\\.qml)$, title:^(Video Wallpapers)$"
        "noblur, class:^(org\\.qt-project\\.qml)$, title:^(Video Wallpapers)$"
        "rounding 12, class:^(org\\.qt-project\\.qml)$, title:^(Video Wallpapers)$"

        # qs-wlogout styling via compositor - power menu overlay
        "noborder, class:^(org\\.qt-project\\.qml)$, title:^(qs-wlogout)$"
        "rounding 20, class:^(org\\.qt-project\\.qml)$, title:^(qs-wlogout)$"
        "opacity 1.0 1.0, class:^(org\\.qt-project\\.qml)$, title:^(qs-wlogout)$"

        # qs-docs / qs-cheatsheets overlay windows
        "noborder, class:^(org\\.qt-project\\.qml)$, title:^(Cheatsheets Viewer)$"
        "noshadow, class:^(org\\.qt-project\\.qml)$, title:^(Cheatsheets Viewer)$"
        "rounding 12, class:^(org\\.qt-project\\.qml)$, title:^(Cheatsheets Viewer)$"
        "noborder, class:^(org\\.qt-project\\.qml)$, title:^(Documentation Viewer)$"
        "noshadow, class:^(org\\.qt-project\\.qml)$, title:^(Documentation Viewer)$"
        "rounding 12, class:^(org\\.qt-project\\.qml)$, title:^(Documentation Viewer)$"
      ];
    };
  };
}
