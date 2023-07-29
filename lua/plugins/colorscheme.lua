return {
 
  { "nvim-tree/nvim-web-devicons", lazy = false },
    --  +----------------------------------------------------------+
    --  |                          theme                           |
    --  +----------------------------------------------------------+
    --theme1
    -- {
    -- 	"RRethy/nvim-base16",
    -- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- 	priority = 1000, -- make sure to load this before all the other start plugins
    -- 	config = function()
    -- 		-- color scheme
    -- 		--vim.cmd.colorscheme("base16-tender")
    -- 		--vim.cmd.colorscheme("base16-gruvbox-dark-soft")
    -- 		--vim.cmd.colorscheme("base16-gruvbox-dark-medium")
   -- 		vim.cmd.colorscheme("base16-gruvbox-dark-pale")
    -- 		--vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
    -- 		--vim.cmd.colorscheme("base16-gruvbox-material-dark-medium")
    -- 		--vim.cmd.colorscheme("base16-gruvbox-material-dark-soft")
    -- 	end,
    -- },

    --     {
    --   "folke/tokyonight.nvim",
    --   lazy = true,
    --   opts = { style = "moon" },
    -- },
    --

    -- theme2
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "mocha", -- latte, frappe, macchiato, mocha
    --         })
    --         vim.cmd.colorscheme("catppuccin")
    --     end
    --
    -- },

    --theme3
    --       {
    --     "shaunsingh/nord.nvim",
    --     lazy=false,
    --     config =function ()
    --     vim.cmd[[colorscheme nord]]
    --     end
    -- },
    --theme4
    {
        "luisiacc/gruvbox-baby",
        lazy = false,
        config = function()
            -- Enable transparent mode
            -- vim.g.gruvbox_baby_transparent_mode = 1
            -- Load the colorscheme
            vim.cmd [[colorscheme gruvbox-baby]]
        end,
    },
    --theme5
    -- {
    --     "rebelot/kanagawa.nvim",
    --     lazy = false,
    --     compile = true,
    --     priority = 1000,
    --     opts = {
    --         overrides = function()
    --             local palette = require("kanagawa.colors").setup().palette
    --             return {
    --                 WinSeparator = { fg = "NONE" },
    --                 TelescopeBorder = { fg = palette.sumiInk0, bg = palette.sumiInk0 },
    --                 TelescopeNormal = { fg = palette.fujiWhite, bg = palette.sumiInk0 },
    --                 TelescopePromptBorder = { fg = palette.sumiInk4, bg = palette.sumiInk4 },
    --                 TelescopePromptNormal = { fg = palette.fujiWhite, bg = palette.sumiInk4 },
    --                 TelescopeSelection = { fg = palette.fujiWhite, bg = palette.sumiInk4 },
    --                 TelescopePreviewTitle = { fg = palette.sumiInk4, bg = palette.oniViolet },
    --                 TelescopePromptTitle = { fg = palette.sumiInk4, bg = palette.sakuraPink },
    --             }
    --         end,
    --     },
    --     config = function(_, opts)
    --         require("kanagawa").setup(opts)
    --         vim.cmd.colorscheme("kanagawa")
    --     end,
    -- },
    --  +----------------------------------------------------------+
    --  |                       status line                        |
    --  +----------------------------------------------------------+
    -- {
    --     "ojroques/nvim-hardline",
    --     lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require("hardline").setup({
    --             bufferline = true,            -- disable bufferline
    --             bufferline_settings = {
    --                 exclude_terminal = true, -- don't show terminal buffers in bufferline
    --                 show_index = true,       -- show buffer indexes (not the actual buffer numbers) in bufferline
    --             },
    --             theme = "gruvbox",            -- change theme
    --             sections = {                  -- define sections
    --                 { class = "mode",   item = require("hardline.parts.mode").get_item },
    --                 -- , hide = 100
    --                 { class = "branch", item = require("hardline.parts.git").get_item },
    --                 { class = "med",    item = require("hardline.parts.filename").get_item },
    --                 -- hide = 60
    --                 "%<",
    --                 { class = "med",     item = "%=" },
    --                 { class = "high",    item = require("hardline.parts.filetype").get_item },
    --
    --                 -- { class = "low", item = require("hardline.parts.wordcount").get_item, hide = 100 },
    --                 { class = "error",   item = require("hardline.parts.lsp").get_error },
    --                 { class = "warning", item = require("hardline.parts.lsp").get_warning },
    --                 --{ class = "med", item = require("hardline.parts.whitespace").get_item },
    --                 { class = "med",     item = require("hardline.parts.line").get_item },
    --                 {
    --                     class = "low",
    --                     item = function()
    --                         return " " .. os.date("%R")
    --                     end,
    --                 },
    --             },
    --         })
    --     end,
    -- },
      -- beautiful buffer line bar
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        mode = "buffers", -- tabs or buffers
        numbers = "buffer_id",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        separator_style = "slant" or "padded_slant",
        show_tab_indicators = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        enforce_regular_tabs = false,
        custom_filter = function(buf_number, _)
          local tab_num = 0
          for _ in pairs(vim.api.nvim_list_tabpages()) do
            tab_num = tab_num + 1
          end

          if tab_num > 1 then
            if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
              return true
            end
          else
            return true
          end
        end,
        sort_by = function(buffer_a, buffer_b)
          local mod_a = ((vim.loop.fs_stat(buffer_a.path) or {}).mtime or {}).sec or 0
          local mod_b = ((vim.loop.fs_stat(buffer_b.path) or {}).mtime or {}).sec or 0
          return mod_a > mod_b
        end,
      },
    },
    config=function ()
        vim.opt.termguicolors = true
require("bufferline").setup{}
    end
  },

{
    "nvim-lualine/lualine.nvim",
        lazy=false,
        dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            section_separators = { left = "", right = "" },
            component_separators = { left = "│", right = "│" },
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                {
                    "diff",
                    symbols = {
                        added = " ",
                        modified = " ",
                        removed = " ",
                    },
                },
                {
                    "diagnostics",
                    symbols = {
                        error = " ",
                        warn = " ",
                        info = " ",
                        hint = " ",
                    },
                },
            },
            lualine_c = {
                {
                    "filetype",
                    icon_only = true,
                    padding = {
                        left = 1,
                        right = 0,
                    },
                    separator = {
                        right = "",
                    },
                },
                "filename",
            },
            lualine_x = {
                function()
                    local count
                    if (vim.fn.mode()):lower() == "v" then
                        count = vim.fn.wordcount().visual_words
                    else
                        count = vim.fn.wordcount().words
                    end
                    return ("%sW"):format(count)
                end,
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        extensions = {
            "nvim-tree",
        },
    },
},


    --  +----------------------------------------------------------+
    --  |                  make theme transparent                  |
    --  +----------------------------------------------------------+
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        keys = {
            { "<leader>uc", "<cmd>TransparentToggle<cr>", mode = { "i", "n", "s" }, desc = "TransparentToggle" },
        },
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {
                    -- "NormalFloat",   -- plugins which have float panel such as Lazy, Mason, LspInfo
                    "NvimTreeNormal" -- NvimTree
                },                   -- table: additional groups that should be cleared
                exclude_groups = {

                    "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
                },                 -- table: groups you don't want to clear
            })
        end
    },


    --  +----------------------------------------------------------+
    --  |                        indentline                        |
    --  +----------------------------------------------------------+
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "BufReadPre",
        -- event = "BufReadPost",
        -- event = "VeryLazy",
        opts = {
            options = { try_as_border = true },
        },
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
            vim.api.nvim_create_autocmd("FileType", {
                --TODO: in neovim alpha,this plugin still work, next try to disable this plugin in the aplha
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            show_end_of_line = true,
            show_current_context = true,
            show_current_context_start = true,
            char = "┆",
        },
        init = function()
            vim.opt.list = true
            vim.opt.listchars:append("eol:↲")
            vim.opt.listchars:append("trail:•")
        end,
    },

    --  +------------------------------------------------------------------------------+
    --  |                           Beautifull notification                            |
    --  +------------------------------------------------------------------------------+
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>nD",
                function() require("notify").dismiss({ silent = true, pending = true }) end,
                desc = "Delete all Notifications",
            },
        },
        opts = {
            timeout = 1000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    --  +----------------------------------------------------------+
    --  |                        noicer ui                         |
    --  +----------------------------------------------------------+
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },

            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
        },
        keys = {
            {
                "<S-Enter>",
                function() require("noice").redirect(vim.fn.getcmdline()) end,
                mode = "c",
                desc =
                "Redirect Cmdline",
            },
            { "<leader>nt", function() require("noice").cmd("telescope") end, desc = "Noice Telescope", },
            { "<leader>nl", function() require("noice").cmd("last") end,      desc = "Noice Last Message", },
            { "<leader>nh", function() require("noice").cmd("history") end,   desc = "Noice History", },
            { "<leader>na", function() require("noice").cmd("all") end,       desc = "Noice All", },
            { "<leader>nd", function() require("noice").cmd("dismiss") end,   desc = "Dismiss All" },
            {
                "<c-f>",
                function()
                    if not require("noice.lsp").scroll(4) then
                        return "<c-f>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll forward",
                mode = { "i", "n", "s" },
            },
            {
                "<c-b>",
                function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<c-b>"
                    end
                end,
                silent = true,
                expr = true,
                desc = "Scroll backward",
                mode = { "i", "n", "s" },
            },
        },
    },



    --  +----------------------------------------------------------+
    --  |                        Dashboard                         |
    --  +----------------------------------------------------------+
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            -- Set header
            local logo = require("util.logo")["random"]
            dashboard.section.header.val = vim.split(logo, "\n")
            -- Set menu
            dashboard.section.buttons.val = {

                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                -- dashboard.button("r", " " .. " Recent files", ":Telescope frecency <CR>"),
                -- dashboard.button("g", " " .. " Grep text", ":Telescope live_grep <CR>"),
                -- dashboard.button("u", "鈴" .. " Update plugins", ":Lazy update<CR>"),
                -- dashboard.button("c", " " .. " Config NeoVim", ":e $MYVIMRC <CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
                -- dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
                -- dashboard.button( "f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
                -- dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
                -- dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
                -- dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
            }
            --   for _, button in ipairs(dashboard.section.buttons.val) do
            --     button.opts.hl = "AlphaButtons"
            --     button.opts.hl_shortcut = "AlphaShortcut"
            --   end
            --   dashboard.section.footer.opts.hl = "Type"
            --   dashboard.section.header.opts.hl = "AlphaHeader"
            --   dashboard.section.buttons.opts.hl = "AlphaButtons"
            --   dashboard.opts.layout[1].val = 8
            --   return dashboard
            -- end
            -- Send config to alpha
            alpha.setup(dashboard.opts)

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
            -- Disable folding on alpha buffer
            vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                    local version = " v" ..
                        vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
                    local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    local footer = "\t" .. version .. "\t" .. plugins
                    dashboard.section.footer.val = footer
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end
    },
  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
     -- high-performance color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({ "css", "scss", "erb", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
}
