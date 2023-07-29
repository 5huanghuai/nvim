return {
    -- search/replace in multiple files
    { "windwp/nvim-spectre" },

    -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        keys = {
            { "<leader>ts", "<cmd>StartupTime<cr>", mode = { "n" }, desc = "Testing StartupTime" },
        },
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    -- terminal toggle
    {
        "akinsho/toggleterm.nvim",
        keys = { { [[<C-\>]], mode = { "n", "v" }, desc = "ToggleTerm" } },
        cmd = { "ToggleTerm", "TermExec" },

        opts = {
            size = 20,
            hide_numbers = true,
            open_mapping = [[<C-\>]],
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 0.3,
            start_in_insert = true,
            persist_size = true,
            direction = "float",
            winbar = {
                enabled = false,
                name_formatter = function(term)
                    return term.name
                end,
            },
        },
    },


    -- buffer remove
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)", },
        },
    },
    -- Easily jump between NeoVim windows
    {
        "yorickpeterse/nvim-window",
        config = function()
            vim.cmd([[hi BlackOnLightYellow guifg=#000000 guibg=#f2de91]])
            require("nvim-window").setup({
                chars = { "a", "s", "f", "g", "h", "j", "k", "l" },
                normal_hl = "BlackOnLightYellow",
                hint_hl = "Bold",
                border = "none",
            })
        end,
    },
    -- Auto-Focusing and Auto-Resizing Splits/Windows
    {
        "beauwilliams/focus.nvim",
        event = "VeryLazy",
        config = function()
            require("focus").setup({
                autoresize = {
                    enabled = true,
                },
                ui = {
                    signcolumn = false,
                },
            })
        end,
    }, 
    -- Range, pattern and substitute preview tool
    -- "xtal8/traces.vim",
    { "markonm/traces.vim" },
    -- Better quickfix window in Neovim
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    
  -- A better user experience for viewing and interacting with Vim marks
  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = true,
  },
  -- new generation multiple cursors plugin,
  -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
  -- create cursors vertically with Ctrl-Down/Ctrl-Up
  -- select one character at a time with Shift-Arrows
  -- press n/N to get next/previous occurrence
  -- press [/] to select next/previous cursor
  -- press q to skip current and get next occurrence
  -- press Q to remove current cursor/selection
  --
  { "mg979/vim-visual-multi", event = "BufReadPre" },--多光标
  -- preview markdown on your modern browser with synchronised scrolling
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },--highlight navigates operator on set of matcing text
      -- viewing all the URLs in a buffer
  {
    "axieax/urlview.nvim",
    event = "VeryLazy",
    config = function()
      require("urlview").setup({
        default_picker = "telescope",
      })
    end,
  },
  -- align text by split chars, defaut hotkey: ga/gA
  {
    "echasnovski/mini.align",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
      {
    "voldikss/vim-translator",
    event = "VeryLazy",
  }, -- Asynchronous translating plugin
}
