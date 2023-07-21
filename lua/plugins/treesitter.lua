local swap_next, swap_prev = (function()
    local swap_objects = {
        p = "@parameter.inner",
        f = "@function.outer",
        c = "@class.outer",
    }

    local n, p = {}, {}
    for key, obj in pairs(swap_objects) do
        n[string.format("<leader>cx%s", key)] = obj
        p[string.format("<leader>cX%s", key)] = obj
    end

    return n, p
end)()

return {

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", --Syntax aware text-objects, select, move, swap, and peek support.
            "nvim-treesitter/nvim-treesitter-refactor",    -- Refactor modules for nvim-treesitter
            "nvim-treesitter/playground",                  --View treesitter information directly in Neovim!
            "RRethy/nvim-treesitter-textsubjects",         --Location and syntax aware text objects which *do what you mean*
            "JoosepAlviste/nvim-ts-context-commentstring", -- A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
            "RRethy/nvim-treesitter-endwise",              --wisely add "end" in ruby, Lua, Vimscript, etc.
            {
                "romgrk/nvim-treesitter-context",
                config = function()
                    require("treesitter-context").setup()
                end,
            }, --Fix the function of the current function to the first few lines of the neovim interface
        },
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = {
                    "c",
                    "c_sharp",
                    -- "help",
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "lua",
                    "vim",
                    "vimdoc",
                    "python",
                    "python",
                    "latex",
                    "fortran",
                },
                highlight = {
                    enable = true,
                    disable = function(_, bufnr) -- Disable in large buffers
                        -- return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 5000
                        return vim.api.nvim_buf_line_count(bufnr) > 5000
                    end,
                },
                indent = { enable = true, disable = { "ruby" } }, --启用treesitter自动缩进功能
                context_commentstring = { enable = true },        --用于配置上下文注释字符串的自动检测和设置功能
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                }, --启用增量选择功能
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    }, --启用快速选择功能
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    }, --启用代码块之间的快速跳转功能
                    -- [ ] +m 跳转前/后一个函数头
                    -- [ ] +M 跳转前/后一个函数尾
                    -- [ ] + [ 跳转前/后一个类头
                    -- [ ] + ] 跳转前/后一个类尾

                    swap = {
                        enable = true,
                        swap_next = swap_next,
                        swap_previous = swap_prev,
                    }, --启用代码块交换功能 选中一个函数或者一个类 使用move中指定的移动 进行交换代码
                    lsp_interop = {
                        enable = true,
                        border = "rounded",
                        peek_definition_code = {
                            ["<leader>da"] = "@function.outer",
                            ["<leader>dA"] = "@class.outer",
                        },
                    },
                }, --  启用 LSP 和 Tree-sitter 的交互功能，并允许你在代码中快速查看函数和类的定义
                textsubjects = {
                    enable = true,
                    prev_selection = ",", -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        [";"] = "textsubjects-container-outer",
                        ["i;"] = "textsubjects-container-inner",
                    },
                }, -- 启用智能文本选择功能 选择文本后 . ; i; 分别表示 当前最小包含 选择外部容器  内部容器

                refactor = {
                    highlight_definitions = { enable = true },   --定义高亮
                    highlight_current_scope = { enable = true }, -- 当前区域高亮
                    navigation = { enable = true },              -- 代码导航区
                    smart_rename = { enable = true },            --智能重命名(一次修改多个变量名字)
                },                                               --启用代码重构功能
                matchup = {
                    enable = true,
                }, -- 启用代码匹配功能 高亮显示匹配的符号对
                playground = {
                    enable = true,
                    updatetime = 25,
                    persist_queries = false,
                }, --启用代码解析器 Playground 功能，用于在代码中进行语法树解析和查询
                --TODO:目前还不知道playgroud是什么a

                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                }, --检查和提示你在查询语句中可能存在的错误

                endwise = {
                    enable = true,
                }, --启用代码自动补全结尾符号的功能，用于自动添加代码块结尾的符号





            })
        end

    }

}
