local Util = require("util")
return {
    -- init.lua:
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim" }, --fzf-native is a c port of fzf
            "nvim-telescope/telescope-symbols.nvim",        -- telescope-symbols provide its users with the ability of picking symbols and insert them at point.
            "nvim-telescope/telescope-project.nvim",        --An extension for telescope.nvim that allows you to switch between projects.
            "nvim-telescope/telescope-file-browser.nvim",   -- telescope-file-browser.nvim is a file browser extension for telescope.nvim
            "nvim-telescope/telescope-frecency.nvim",       --A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
            "nvim-telescope/telescope-smart-history.nvim",  --A history implementation that memorizes prompt input for a specific context.
            "nvim-telescope/telescope-live-grep-args.nvim", --It enables passing arguments to the grep command
            "aaronhallaert/advanced-git-search.nvim",       --Search your git history by commit message, content and author in Neovim
            "tsakirist/telescope-lazy.nvim",                --Telescope extension that provides handy functionality about plugins installed via lazy.nvim.
            "crispgm/telescope-heading.nvim",               --it's useful to markdown, An extension for telescope.nvim that allows you to switch between document's headings.
            "kkharji/sqlite.lua",                           --SQLite/LuaJIT binding and a highly opinionated wrapper for storing, retrieving, caching, and persisting SQLite databases
            "otavioschwanck/telescope-alternate",           --An extension for telescope.nvim that allows you to switch between projects.
                 {
        "rmagatti/auto-session", -- Auto Session takes advantage of Neovim's existing session management capabilities to provide seamless automatic session management
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require("auto-session").setup({
            auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
            auto_session_enabled = true,
            auto_session_enable_last_session = false,
            auto_session_use_git_branch = true,
          })
        end,
      },            { "rmagatti/session-lens",                   event = { "BufReadPre", "BufNewFile" }, config = true },
        },
        keys = {
            { "<C-p>",      ":Telescope find_files<CR>",       desc = "find files" },
            { "<leader>ff", "<cmd>Telescope file_browser<cr>", desc = "Browser" },
            {
                "<leader>fo",
                "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
                desc = "Browser on current buffer",
            },
            { "<leader>fg", ":Telescope live_grep<CR>", desc = "grep file" },
            { "<leader>fb", ":Telescope resume<CR>",    desc = "resume" },
            { "<leader>fh", ":Telescope oldfiles<CR>",  desc = "oldfiles" },
            {
                "<leader>cs",
                Util.telescope("lsp_document_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol",
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local actions_layout = require("telescope.actions.layout")
            local lga_actions = require('telescope-live-grep-args.actions')
            local enter_normal_mode = function()
                local mode = vim.api.nvim_get_mode().mode
                if mode == "i" then
                    vim.cmd [[stopinsert]]
                    return
                end
            end
            -- telescope.load_extension("file_browser")
            -- telescope.load_extension("frecency")
            -- telescope.load_extension("smart_history")
            -- telescope.load_extension("live_grep_args")
            -- telescope.load_extension("advanced_git_search")
            -- telescope.load_extension("lazy")
            -- telescope.load_extension("heading")
            -- telescope.load_extension("session-lens")
            -- telescope.load_extension('telescope-alternate')
            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending", --排序方式 升序
                    layout_strategy = "flex",
                    layout_config = {
                        prompt_position = "top",
                    },
                    dynamic_preview_title = true,
                    prompt_prefix = " ",
                    selection_caret = " ",
                    path_display = { "truncate" },
                    file_ignore_patterns = { "node_modules", "vendor/bundle", "%.jpg", "%.png" },
                    history = {
                        path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
                    },

                    mappings = {
                        i = {
                            ["<Tab>"] = actions.toggle_selection,
                            ["jj"] = actions.close,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-h>"] = actions.cycle_history_next,
                            ["<C-l>"] = actions.cycle_history_prev,
                            ["<C-g>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<c-t>"] = function(...)
                                return require("trouble.providers.telescope").open_with_trouble(...)
                            end,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                },
                    extensions = {
                        fzf = {
                            case_mode = "smart_case",
                            fuzzy = true,
                            override_file_sorter = true,
                            override_generic_sorter = true,
                        },
                        file_browser = {
                            theme = "ivy",
                            hijack_netrw = true,
                        },
                        frecency = {
                            default_workspace = 'CWD',
                            show_unindexed = false,
                            ignore_patterns = { '*.git/*', '*node_modules/*', '*vendor/*' },
                        },

                        live_grep_args = {
                            auto_quoting = true,
                            mappings = {
                                i = {
                                    ["<C-e>"] = lga_actions.quote_prompt(),
                                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                                    ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
                                    ["<C-h>"] = lga_actions.quote_prompt({ postfix = " -truby lib app ee jh -g '!spec/'" }),
                                },
                            },
                        },
                        advanced_git_search = {
                            diff_plugin = "fugitive",
                            show_builtin_git_pickers = false,
                            git_flags = {},
                            git_diff_flags = {},
                        },
                        ["telescope-alternate"] = {
                            mappings = {
                                {
                                    pattern = 'app/services/(.*)_services/(.*).rb',
                                    targets = {
                                        { template = 'app/contracts/[1]_contracts/[2].rb', label = 'Contract',
                                            enable_new = true }                                       -- enable_new can be a function too.
                                    }
                                },
                                {
                                    pattern = 'app/contracts/(.*)_contracts/(.*).rb',
                                    targets = {
                                        { template = 'app/services/[1]_services/[2].rb', label = 'Service', enable_new = true }
                                    }
                                },
                            },
                            presets = { 'rails', 'nestjs' }
                        },

                    },
            })

            vim.api.nvim_create_user_command(
                "DiffCommitLine",
                "lua require('telescope').extensions.advanced_git_search.diff_commit_line()",
                { range = true }
            )
            vim.api.nvim_set_keymap("v", "<leader>gl", ":DiffCommitLine<CR>", { noremap = true })

            vim.api.nvim_set_keymap("n", "g]", ":lua require('telescope').extensions.ctags_plus.jump_to_tag()<CR>",
                { noremap = true })
            vim.api.nvim_set_keymap("n", "<leader>o", ":Telescope ctags_outline outline<CR>", { noremap = true })
        end,

    },


}
