return {
    --dap
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "leoluz/nvim-dap-go" },
            { "mfussenegger/nvim-dap-python" },
        },

        keys = {
            { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end,
                                                                                                             desc =
                "Evaluate Input", },
            { "<leader>dS", function() require("dap.ui.widgets").scopes() end,                           desc = "Scopes", },
            { "<leader>dU", function() require("dapui").toggle() end,                                    desc =
            "Toggle UI", },
            { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end,
                                                                                                             desc =
                "Conditional Breakpoint", },
            { "<leader>dR", function() require("dap").run_to_cursor() end,                               desc =
            "Run to Cursor", },
            { "<leader>db", function() require("dap").step_back() end,                                   desc =
            "Step Back", },
            { "<leader>dc", function() require("dap").continue() end,                                    desc =
            "Continue", },
            { "<leader>dd", function() require("dap").disconnect() end,                                  desc =
            "Disconnect", },
            { "<leader>de", function() require("dapui").eval() end,                                      mode = { "n",
                "v" },                                                                                                                    desc =
            "Evaluate", },
            { "<leader>dg", function() require("dap").session() end,                                     desc =
            "Get Session", },
            { "<leader>dh", function() require("dap.ui.widgets").hover() end,                            desc =
            "Hover Variables", },
            { "<leader>di", function() require("dap").step_into() end,                                   desc =
            "Step Into", },
            { "<leader>du", function() require("dap").step_out() end,                                    desc =
            "Step Out", },
            { "<leader>do", function() require("dap").step_over() end,                                   desc =
            "Step Over", },
            { "<leader>dp", function() require("dap").pause.toggle() end,                                desc = "Pause", },
            { "<leader>dq", function() require("dap").close() end,                                       desc = "Quit", },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                 desc =
            "Toggle REPL", },
            { "<leader>ds", function() require("dap").continue() end,                                    desc = "Start", },
            { "<leader>dt", function() require("dap").toggle_breakpoint() end,                           desc =
            "Toggle Breakpoint", },
            { "<leader>dx", function() require("dap").terminate() end,                                   desc =
            "Terminate", },
        },

        config = function()
            require("nvim-dap-virtual-text").setup {
                commented = true,
            }

            local dap, dapui = require "dap", require "dapui"
            dapui.setup {}

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            require("dap.ext.vscode").load_launchjs()
            require("telescope").load_extension "dap"
            -- adapters
            require("dap-go").setup()
            require("dap-python").setup()
        end,

    },
    -- test running tool for many languages
    -- TODO: 这部分配置还没完善，不知道怎么用，没有配置python的测试
    {
        "vim-test/vim-test",
        keys = {
            { "<leader>tc", "<cmd>TestClass<cr>",   desc = "Class" },
            { "<leader>tf", "<cmd>TestFile<cr>",    desc = "File" },
            { "<leader>tl", "<cmd>TestLast<cr>",    desc = "Last" },
            { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Nearest" },
            { "<leader>ts", "<cmd>TestSuite<cr>",   desc = "Suite" },
            { "<leader>tv", "<cmd>TestVisit<cr>",   desc = "Visit" },
        },
        config = function()
            vim.g["test#strategy"] = "neovim" -- 'basic' or 'neovim'
            vim.g["test#neovim#term_position"] = "belowright"
            vim.g["test#neovim#preserve_screen"] = 1
            vim.g["test#ruby#rspec#executable"] = "bundle exec rspec"
            vim.g["test#go#gotest#executable"] = "go test -v"
        end,
    },

}
