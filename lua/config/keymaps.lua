local keymap = vim.keymap.set --rename



-- rename quite ane save
keymap({ "n", "v", "o" }, "<leader>qq", ":q!<CR>", { desc = "quite and not save" })

keymap({ "n", "v", "o" }, "<leader>wq", ":wq<CR>", { desc = "quite and save" })
-- keymap({ "n", "v", "o" }, "<leader>ww", ":w<CR>", { desc = "save" })

-- "J"向上移动8行
keymap({ "n", "v", "o" }, "J", "8j", { desc = "8 j" })
-- "K"向下移动8行
keymap({ "n", "v", "o" }, "K", "8k", { desc = "8 k" })

--buffer switch
--keymap("n", "<C-]>", "<C-o>")
--keymap("n", "<C-[>", "<C-i>")

keymap("n", "<A-Tab>", "<c-^>") -- Switch between 2 buffers
-- dealing with word wrap
keymap("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

--split window
keymap("n", "<C-g>", [[<Cmd>sp<CR>]])
keymap("n", "<C-b>", [[<Cmd>vsp<CR>]])

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
