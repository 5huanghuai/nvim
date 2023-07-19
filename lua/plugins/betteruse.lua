return{

--  +----------------------------------------------------------+
--  |                      better comment                      |
--  +----------------------------------------------------------+

-- mini comment
{ 'echasnovski/mini.nvim', 
version = false,
event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
},

-- create box and line
	{
		"LudoPinelli/comment-box.nvim",
		keys = {
			{ "<leader>bh", "<cmd>CBcatalog<cr>", desc = "help for comment-box" },
			{ "<leader>bb", "<cmd>CBcbox10<cr>", desc = "create a box" },
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
			{"]t",function()require("todo-comments").jump_next()end,desc = "Next todo comment",},
			{"[t",function()require("todo-comments").jump_prev()end,desc = "Previous todo comment",},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find Todo" },
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
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<leader>S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<leader>R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<leader>tf", mode = {  "n", "v", "x", "o","c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
 },




}
