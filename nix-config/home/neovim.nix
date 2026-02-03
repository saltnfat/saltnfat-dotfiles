{ pkgs, inputs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        # LSPs
        bash-language-server
        biome
        # ethersync # not ready yet - needs ethersync-nvim plugin too which is not available on nixpkgs yet
        lua-language-server
        marksman
        nil
        stylelint-lsp
        tailwindcss-language-server
        typescript-language-server
        yaml-language-server
        # formatters
        shfmt # bash
        nixfmt
        stylelint
        stylua
      ];
      plugins = with pkgs.vimPlugins; [
        # automated session management
        auto-session
        # snazzy buffer line
        bufferline-nvim
        # vscode-like winbar to get LSP context from LSP
        barbecue-nvim
        catppuccin-nvim
        # luasnip completion source for nvim-cmp
        cmp_luasnip
        # replaces nvim default omnifunc to support more types of completion candidates
        cmp-nvim-lsp
        # nvim-cmp source for buffer words
        cmp-buffer
        # better code formatter, requires setup (https://github.com/stevearc/conform.nvim/)
        conform-nvim
        comment-nvim
        # startup screen
        #dashboard-nvim
        # improve default vim.ui interfaces
        dressing-nvim
        # quickly jump to different areas in current buffer
        flash-nvim
        # large colletion of code snippets (use w/ snippet plugin like luasnip)
        friendly-snippets
        # fast git decorations - can integrate with vim-fugitive and trouble.nvim
        gitsigns-nvim
        # vertical guide lines for indentation levels
        indent-blankline-nvim
        # configures lua LSP for editing neovim config by lazily updating workspace libs
        lazydev-nvim
        # adds vscode-like pictograms to neovim built-in lsp
        lspkind-nvim
        # renders lsp diagnostic info using virtual lines on top of real code
        lsp_lines-nvim
        # fast status line
        lualine-nvim
        # snippet engine
        luasnip
        # icons (dep for other plugins)
        mini-icons
        # code completion using LLMs
        minuet-ai-nvim
        # replaces UI for messages, cmdline, and popupmenu
        noice-nvim
        # dep for noice-nvim
        nui-nvim
        nvim-autopairs
        # completion
        nvim-cmp
        # quickstart configs for LSPs
        nvim-lspconfig
        # dep for barbecue-nvim
        nvim-navic
        # dep for noice-nvim
        nvim-notify
        nvim-treesitter.withAllGrammars
        # Use treesitter to autoclose and autorename html tag
        nvim-ts-autotag
        # setting comment string based on cursor location in file
        nvim-ts-context-commentstring
        # dep for other plugins
        nvim-web-devicons
        # quick outline tree (like table of contents) (compatible w/ lsp)
        outline-nvim
        # lua functions (dep for plugins)
        plenary-nvim
        # render markdown directly in neovim
        render-markdown-nvim
        # misc QoL plugins like image support
        snacks-nvim
        # Additional tooling and integration of tailwindcss lsp and neovim
        tailwind-tools-nvim
        telescope-fzf-native-nvim
        # extendable fuzzy finder over lists
        telescope-nvim
        todo-comments-nvim
        # pretty list for showing diagnostics, references, etc. to solve trouble code is causing
        trouble-nvim
        # better, faster replacement for typescript-language-server
        typescript-tools-nvim
        # async display colors in a file (e.g. show what color a hex or rgb code is)
        vim-hexokinase
        # support for writing nix expressions in vim
        vim-nix
        # file manager
        mini-files
        # auto pairs like parentheses, etc.
        #mini-pairs
        # add/delete/change surrounding pairs like parentheses, etc.
        mini-surround
        # move between vim and tmux panes seamlessly
        vim-tmux-navigator
        # check keybinds easily
        which-key-nvim
        # explain lsp error or debug messages
        wtf-nvim
      ];
      extraConfig = "";
      initLua = ''
        ${builtins.readFile ./nvim/keymaps.lua}
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/plugins/cmp.lua}
        ${builtins.readFile ./nvim/plugins/conform.lua}
        ${builtins.readFile ./nvim/plugins/lsp.lua}
        ${builtins.readFile ./nvim/plugins/lualine.lua}
        ${builtins.readFile ./nvim/plugins/misc.lua}
        ${builtins.readFile ./nvim/plugins/telescope.lua}
        vim.diagnostic.config({
          virtual_text = false,
        })
      '';
    };
  };
}
#
