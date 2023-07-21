return {

    --  +----------------------------------------------------------+
    --  |                         copilot                          |
    --  +----------------------------------------------------------+
    --测试copilot



    {
        "github/copilot.vim",
        event = "VeryLazy",
        dependencies = {
            "Shougo/vimproc.vim",
            "Shougo/vimshell.vim",
            "Shougo/unite.vim",
        },
        keys = {
            --这里vim对copilot的键位设置
            { "<C-l>", 'copilot#Accept("<CR>")', desc = "accept copilot suggestion" },
            --TODO: 这里的键位设置有问题，不知道怎么设置

            --{ "<C-K>", '<Plug>(copilot-previous)', desc = "insert copilot suggestion" },
            --           { "<C-J>", '<Plug>(copilot-next)', desc = "insert copilot suggestion" },

        },
        config = function()
            vim.api.nvim_set_keymap("!", "<C-l>", 'copilot#Accept("<CR>")',
                { silent = true, expr = true, noremap = true })
            vim.api.nvim_set_var('copilot_assume_mapped', true)
            --TODO: 这里highlight 也有问题
            --vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])

            -- require(copilot.vim).setup()
        end
    },


    --  +----------------------------------------------------------+
    --  |                      better comment                      |
    --  +----------------------------------------------------------+


    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true }, --  don't know the effect

    -- mini comment
    {
        'echasnovski/mini.nvim',
        version = false,
        event = "VeryLazy",
        --    opts = {
        --      hooks = {
        --        pre = function()
        --          require("ts_context_commentstring.internal").update_commentstring({})
        --        end,
        --      },
        --    },
        --    config = function(_, opts)
        --      require("mini.comment").setup(opts)
        --    end,
        config = function()
            require("mini.comment").setup()
        end

    },

    -- create box and line
    {
        "LudoPinelli/comment-box.nvim",
        keys = {
            { "<leader>bh", "<cmd>CBcatalog<cr>", desc = "help for comment-box" },
            { "<leader>bb", "<cmd>CBcbox10<cr>",  desc = "create a box" },
            { "<leader>bl", "<cmd>CBcline10<cr>", desc = "create a line" },
        },
    },

    -- todo comment
    {
        --NOTE: how to use : input the key words  "TODO,NOTE,FIX,WARNING,HACK,BUG,PERF" and : and input some comments words
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "BufReadPost",
        opts = {

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment", },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>fT", "<cmd>TodoTelescope<cr>",                            desc = "Find Todo" },
        },
    },

    -- auto restore fcitx status
    {
        "h-hg/fcitx.nvim",
        event = "VeryLazy",
    },

    -- better jump
    {
        "folke/flash.nvim",
        -- event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            {
                "<leader>s",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc =
                "Flash"
            },
            {
                "<leader>S",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "<leader>r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "<leader>R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<leader>tf",
                mode = { "n", "v", "x", "o", "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },




}
