return {
	--telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", ":Telescope find_files<CR>", desc = "find files" },
			{ "<leader>fg", ":Telescope live_grep<CR>", desc = "grep file" },
			{ "<leader>fb", ":Telescope resume<CR>", desc = "resume" },
			{ "<leader>fh", ":Telescope oldfiles<CR>", desc = "oldfiles" },
		},
	},
}
