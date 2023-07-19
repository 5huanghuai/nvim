--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.relativenumber = true --relatvive number
opt.number=true -- number
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = true -- Enable highlighting of the current column
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.tabstop = 4 --the width of tab 
opt.expandtab = true --use spaces instead of tabs
opt.shiftwidth = 4 --must set this to 4,in order to make <tab> indentate 4 space

