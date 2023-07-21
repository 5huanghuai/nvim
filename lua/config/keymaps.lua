
local keymap = vim.keymap.set --rename
-- Input shortcuts
keymap("i", "uu", "_")
keymap("i", "hh", "-")
keymap("i", "ii", "=")
keymap("i", "kk", "->")
keymap("i", "jk", "=>")
keymap("i", "vv", "<bar>>")

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')
-- Yank and paste
keymap("n", "Y", "y$") -- Yanking to the end of line
keymap("n", "p", "p`[") -- Paste yank after, keep cursor position
keymap("n", "P", "P`[") -- Paste yank before, keep cursor position



-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")
-- Insert New Line quickly
vim.cmd("nnoremap <Enter> o<ESC>")
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

-- keymap("n", "<A-Tab>", "<c-^>") -- Switch between 2 buffers
keymap("n", "<leader><leader>", "<c-^>") -- Switch between 2 buffers
-- dealing with word wrap
keymap("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

-- Better escape using jk in insert and terminal mode
keymap("i", "jj", "<ESC>")
keymap("t", "jj", "<C-\\><C-n>")
--split window
keymap("n", "<C-g>", [[<Cmd>sp<CR>]])
keymap("n", "<C-b>", [[<Cmd>vsp<CR>]])

-- -- Move to window using the <ctrl> hjkl keys
keymap("n", "<A-h>", "<C-w>h")
keymap("n", "<A-j>", "<C-w>j")
keymap("n", "<A-k>", "<C-w>k")
keymap("n", "<A-l>", "<C-w>l")

-- Resize window using <shift> arrow keys
keymap("n", "<A-Up>", "<cmd>resize +2<CR>")
keymap("n", "<A-Down>", "<cmd>resize -2<CR>")
keymap("n", "<A-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<A-Right>", "<cmd>vertical resize +2<CR>")

-- Toggle diff buffers
keymap("n", "<leader>dft", "&diff ? ':windo diffoff<cr>' : ':windo diffthis<cr>'", { expr = true })
