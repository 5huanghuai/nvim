local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- config lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		--{ import = "plugins/lsp" },
	},
	concurrency = 24,
	defaults = { lazy = true, version = nil },
})

vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })
