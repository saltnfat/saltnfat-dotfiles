{ pkgs, config, ... }:
let
  tmux-sessionx-old = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-sessionx";
    version = "unstable-2024-06-25";
    src = pkgs.fetchFromGitHub {
      owner = "omerxx";
      repo = "tmux-sessionx";
      rev = "ecc926e7db7761bfbd798cd8f10043e4fb1b83ba";
      sha256 = "sha256-S/1mcmOrNKkzRDwMLGqnLUbvzUxcO1EcMdPwcipRQuE=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      sensible
      yank
      resurrect
      continuum
      tmux-thumbs
      tmux-fzf
      fzf-tmux-url
      vim-tmux-navigator
      catppuccin
      tmux-floax
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
    ];
    extraConfig = ''
      # First remove *all* keybindings
      # unbind-key -a
      # Now reinsert all the regular tmux keys
      bind ^X lock-server
      bind c new-window -c "$HOME"
      bind ^D detach
      bind * list-clients

      # -n doesn't require prefix key first
      bind-key -n C-e previous-window
      bind-key -n C-o next-window
      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R
      bind-key -n C-S-F2 new-session


      bind T new-window -c "$HOME"
      bind r command-prompt "rename-window %%"
      bind R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded..."
      bind ^A last-window
      bind ^W list-windows
      bind w list-windows
      bind z resize-pane -Z
      bind ^L refresh-client
      bind l refresh-client
      bind | split-window
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind '"' choose-window

      bind -r -T prefix , resize-pane -L 20
      bind -r -T prefix . resize-pane -R 20
      bind -r -T prefix - resize-pane -D 7
      bind -r -T prefix = resize-pane -U 7
      bind : command-prompt
      bind * setw synchronize-panes
      bind P set pane-border-status
      bind k kill-pane
      bind x swap-pane -D
      bind S choose-session
      bind K send-keys "clear"\; send-keys "Enter"
      bind-key -T copy-mode-vi v send-keys -X begin-selection



      set -g prefix ^A
      set -g base-index 1              # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g escape-time 0             # zero-out escape time delay
      set -g history-limit 1000000     # increase history size (from 2,000)
      set -g renumber-windows on       # renumber all windows when any window is closed
      set -g set-clipboard on          # use system clipboard
      setw -g mode-keys vi
      set-option -g mouse on
      set -gq allow-passthrough         # so we can apply term colors to neovim 

      set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
      set -g @fzf-url-history-limit '2000'


      set -g @continuum-restore 'on'
      set -g @resurrect-strategy-nvim 'session'

      # make sure we can use 24-bit or True Color.  For some reason using $TERM 
      # instead of tmux-256color causes issues when typing (at least in Alacritty)
      #set -g default-terminal '\$\{TERM}'
      set -g default-terminal 'tmux-256color'
      set -sg terminal-overrides ',*:RGB'

      # setting these 2 options (along with an certain keyboard settings in alacritty) makes sure
      # we can use Ctrl-[0-9] for actual keybindings (like buffer prev/next in neovim)
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'

      ## Tmux bar customization (includes Window and Status bar areas)
      set -g @catppuccin_flavor 'mocha'
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-interval 1

      set-window-option -g window-status-style 'fg=#{@thm_surface_2}'
      set-window-option -g window-status-current-style 'italics'
      set-window-option -g automatic-rename on
      set-window-option -g automatic-rename-format '#{b:pane_current_path}'

      # set status bar background transparent
      set -g status-style fg=default,bg=default 
      set -g @catppuccin_status_background "none"

      set -g @catppuccin_flavor "macchiato"
      set -g @catppuccin_window_status "icon"
      set -g @catppuccin_window_status_style "custom"
      set -g @catppuccin_pane_status_enabled "yes" 
      set -g @catppuccin_pane_border_status "yes"
      # set -g @catppuccin_window_flags "icon"
      set -g @catppuccin_window_current_text_color "#[bg=default,fg=#{@thm_flamingo}"
      set -g @catppuccin_window_text_color "#[bg=default,fg=#{@thm_surface_2}"
      set -g @catppuccin_window_left_separator "#[bg=default,fg=#{@thm_surface_2}] #[bg=default,fg=#{@thm_surface_2}]"
      set -g @catppuccin_window_right_separator "#[bg=default,fg=#{@thm_surface_2}] #[bg=default,fg=#{@thm_surface_2}]"
      set -g @catppuccin_window_current_left_separator "#[bg=default,fg=#{@thm_flamingo}] "
      set -g @catppuccin_window_current_middle_separator ""
      set -g @catppuccin_window_current_right_separator "#[bg=default,fg=#{@thm_flamingo}] #[fg=#{@thm_surface_2}]"
      # set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_status_left_separator ""
      set -g @catppuccin_status_middle_separator ""
      set -g @catppuccin_status_right_separator " "

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set-option -g window-status-style 'fg=#{@thm_surface_2}'
      set-option -g window-status-separator "#[fg=#585b70]•"
      # set -ag status-right "#{E:@catppuccin_status_uptime}"
      # set -g @catppuccin_window_default_text "#[bg=default,fg=#{@thm_mauve}] #W"
      set -g @catppuccin_window_text " #W"
      set -g @catppuccin_window_current_text " #W#{?window_zoomed_flag, 󰊓,}"
      set -g @catppuccin_pane_default_text "#{b:pane_current_path}"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
      set -g @catppuccin_status_background "none"
      set -g @catppuccin_menu_selected_style "fg=#{@thm_fg},italics"
      set -g @catppuccin_status_connect_separator "no"

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
            
    '';
  };
}
