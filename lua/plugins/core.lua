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
      { "rizzatti/dash.vim", event = "VeryLazy" },

  -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },

  -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
  {
    "AndrewRadev/switch.vim",
    keys = {
      { "gt", "<cmd>Switch<cr>", desc = "Switch" },
    },
  },
 -- allows you to open associated files for the currently active buffer. For example, while editing a controller, you can conveniently open a view, model, or testcase without using a fuzzy finder or tree
  {
    "rgroli/other.nvim" ,
    event = "VeryLazy",
    keys = {
      { "<leader>lo", "<cmd>Other<cr>", desc = "Open other file" },
      { "<leader>lc", "<cmd>OtherClear<cr>", desc = "Clear reference of other file" },
    },
    config = function()
      require("other-nvim").setup({
        mappings = {
          "rails",
          "golang",
        },
        style = {
          border = "rounded",
          width = 0.6,
        },
      })
    end,
  },



  -- refactoring library based off the Refactoring book by Martin Fowler
    -- 重构代码
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension "refactoring"
    end,
    keys = function ()
      vim.api.nvim_set_keymap(
        "v",
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true, silent = true }
      )
    end
  },
  -- references
    --TODO: 这个目前设置好像有点问题，之后再说
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference", },
    },

  },
      -- Better diagnostics list and others
    -- 诊断列表，更快的诊断问题
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
      -- better text-objects
    --TODO:目前不清楚这个插件的作用
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      if require("util").has "which-key.nvim" then
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs { n = "Next", l = "Last" } do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register {
          mode = { "o", "x" },
          i = i,
          a = a,
        }
      end
    end,
  },
      -- surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
      -- tabbing out from parentheses, quotes, and similar contexts
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },

      -- switch segments of text with predefined replacements. default mapping `gs` to trigger the command
    -- TODO:目前不清楚这个插件的作用
  {
    "AndrewRadev/switch.vim",
    keys = {
      { "gt", "<cmd>Switch<cr>", desc = "Switch" },
    },
  },
      { "rizzatti/dash.vim", event = "VeryLazy" },

  -- Switch between single-line and multiline forms of code: gS to split a one-liner into multiple lines. gJ (with the cursor on the first line of a block) to join a block into a single-line.
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
}
