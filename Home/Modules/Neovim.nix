{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      rust-analyzer
      nixd
      bash-language-server
      yaml-language-server
      rustfmt
      nixfmt
      gcc
      ripgrep
      lldb
    ];

    plugins = with pkgs.vimPlugins; [
      alpha-nvim
      nvim-web-devicons
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      (nvim-treesitter.withPlugins (
        p: with p; [
          rust
          nix
          bash
          yaml
          toml
          json
          lua
        ]
      ))
      nvim-treesitter-context
      telescope-nvim
      plenary-nvim
      neo-tree-nvim
      nui-nvim
      vim-fugitive
      lualine-nvim
      crates-nvim
      cord-nvim
      which-key-nvim # Il popup per le shortcut
      trouble-nvim
      nvim-surround
      nvim-notify # Le notifiche belle
      nvim-dap
      nvim-dap-ui
    ];

    initLua = ''
      -- Leader
      vim.g.mapleader = " "

      -- --- OPZIONI CORE ---
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.number = true
      vim.opt.termguicolors = true
      vim.opt.wrap = true
      vim.opt.linebreak = true

      -- --- NOTIFICHE BELLE (nvim-notify) ---
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        background_colour = "#000000",
        stages = "fade",
        timeout = 3000,
      })

      -- Trasparenza
      local hl_groups = { "Normal", "NormalFloat", "NormalNC", "SignColumn", "EndOfBuffer", "NeoTreeNormal", "NeoTreeNormalNC" }
      for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end

      -- Helper Keymaps
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- --- KEYBINDS EVIEVIM ---
      map("n", "<C-a>", "ggVG", "Select all")
      map("v", "<C-c>", '"+y', "Copy")
      map("v", "<C-x>", '"+x', "Cut")
      map("n", "<C-v>", '"+p', "Paste")
      map("i", "<C-v>", '<C-r>+', "Paste")
      map("n", "<C-z>", "u", "Undo")
      map("n", "<C-y>", "<C-r>", "Redo")
      map("n", "<C-t>", ":Neotree toggle<CR>", "Toggle tree")
      map("n", "<C-q>", ":Alpha<CR>", "Dashboard")
      map("n", "<leader>f", function() vim.lsp.buf.format() end, "Format file")
      map("n", "<Down>", "gj", "Move down")
      map("n", "<Up>", "gk", "Move up")

      -- --- WHICH-KEY (Il Popup Carino) ---
      local wk = require("which-key")
      wk.setup({ delay = 0 })

      -- Ctrl+K ora apre il popup di Which-Key per farti vedere tutto!
      map("n", "<C-k>", "<cmd>WhichKey<cr>", "Show Keybinds Popup")

      -- LSP Keybinds
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "gr", vim.lsp.buf.references, "Go to References")
      map("n", "K", vim.lsp.buf.hover, "Hover Doc")
      map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

      -- --- UNIVERSAL FORMAT ON SAVE ---
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.nix", "*.rs" },
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })

      -- --- DASHBOARD (ALPHA) ---
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        "                                                   ",
        " \u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2557}   \u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2557}   \u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2557}\u{2588}\u{2588}\u{2588}\u{2557}   \u{2588}\u{2588}\u{2588}\u{2557}",
        " \u{2588}\u{2588}\u{2554}\u{2550}\u{2550}\u{2550}\u{2550}\u{255D}\u{2588}\u{2588}\u{2551}   \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2554}\u{2550}\u{2550}\u{2550}\u{2550}\u{255D}\u{2588}\u{2588}\u{2551}   \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557} \u{2588}\u{2588}\u{2588}\u{2588}\u{2551}",
        " \u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557}  \u{2588}\u{2588}\u{2551}   \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557}  \u{2588}\u{2588}\u{2551}   \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2554}\u{2588}\u{2588}\u{2588}\u{2588}\u{2554}\u{2588}\u{2588}\u{2551}",
        " \u{2588}\u{2588}\u{2554}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2588}\u{2588}\u{2557} \u{2588}\u{2588}\u{2554}\u{255D}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2554}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2588}\u{2588}\u{2557} \u{2588}\u{2588}\u{2554}\u{255D}\u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551}\u{255A}\u{2588}\u{2588}\u{2554}\u{255D}\u{2588}\u{2588}\u{2551}",
        " \u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557} \u{255A}\u{2588}\u{2588}\u{2588}\u{2588}\u{2554}\u{255D} \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2557} \u{255A}\u{2588}\u{2588}\u{2588}\u{2588}\u{2554}\u{255D} \u{2588}\u{2588}\u{2551}\u{2588}\u{2588}\u{2551} \u{255A}\u{2550}\u{255D} \u{2588}\u{2588}\u{2551}",
        " \u{255A}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2550}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2550}\u{255D}\u{255A}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2550}\u{2550}\u{2550}\u{255D}  \u{255A}\u{2550}\u{255D}\u{255A}\u{2550}\u{255D}     \u{255A}\u{2550}\u{255D}",
        "                                                   ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "\u{f15b}  New file",     ":enew<CR>"),
        dashboard.button("f", "\u{f002}  Find file",    ":Telescope find_files<CR>"),
        dashboard.button("r", "\u{f7d9}  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "\u{f422}  Find word",    ":Telescope live_grep<CR>"),
        dashboard.button("q", "\u{f011}  Quit",         ":qa<CR>"),
      }
      alpha.setup(dashboard.config)

      -- --- LSP SETUP (Nuovo Standard) ---
      local caps = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('nixd', {
        capabilities = caps,
        settings = { nixd = { formatting = { command = { "nixfmt" } } } }
      })
      vim.lsp.config('rust_analyzer', { capabilities = caps })
      vim.lsp.config('bashls', { capabilities = caps })
      vim.lsp.config('yamlls', { capabilities = caps })
      vim.lsp.enable({ 'nixd', 'rust_analyzer', 'bashls', 'yamlls' })

      -- --- COMPLETION ---
      local cmp = require('cmp')
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({{ name = 'nvim_lsp' }, { name = 'luasnip' }}, {{ name = 'buffer' }})
      })

      -- --- ALTRI PLUGIN ---
      require('lualine').setup()
      require('neo-tree').setup({ filesystem = { follow_current_file = { enabled = true } } })
      require('telescope').setup()
      require('cord').setup({})

      -- Treesitter
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "rust", "nix", "bash", "lua" },
        callback = function() vim.treesitter.start() end,
      })
    '';
  };
}
