return {

	-- theme
	{
		"RRethy/nvim-base16",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- color scheme
			--vim.cmd.colorscheme("base16-tender")
			--vim.cmd.colorscheme("base16-gruvbox-dark-soft")
			--vim.cmd.colorscheme("base16-gruvbox-dark-medium")
			vim.cmd.colorscheme("base16-gruvbox-dark-pale")
			--vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
			--vim.cmd.colorscheme("base16-gruvbox-material-dark-medium")
			--vim.cmd.colorscheme("base16-gruvbox-material-dark-soft")
		end,
	},

	--status line
	{
		"ojroques/nvim-hardline",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("hardline").setup({
				bufferline = true, -- disable bufferline
				bufferline_settings = {
					exclude_terminal = false, -- don't show terminal buffers in bufferline
					show_index = false, -- show buffer indexes (not the actual buffer numbers) in bufferline
				},
				theme = "default", -- change theme
				sections = { -- define sections
					{ class = "mode", item = require("hardline.parts.mode").get_item },
					{ class = "high", item = require("hardline.parts.git").get_item, hide = 100 },
					{ class = "med", item = require("hardline.parts.filename").get_item },
					"%<",
					{ class = "med", item = "%=" },
					{ class = "low", item = require("hardline.parts.wordcount").get_item, hide = 100 },
					{ class = "error", item = require("hardline.parts.lsp").get_error },
					{ class = "warning", item = require("hardline.parts.lsp").get_warning },
					{ class = "warning", item = require("hardline.parts.whitespace").get_item },
					{ class = "high", item = require("hardline.parts.filetype").get_item, hide = 60 },
					{ class = "mode", item = require("hardline.parts.line").get_item },
				},
			})
		end,
	},
}
