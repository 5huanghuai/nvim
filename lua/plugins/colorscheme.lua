return{
--  +----------------------------------------------------------+
--  |                        indentline                        |
--  +----------------------------------------------------------+
{
"echasnovski/mini.indentscope",
version = false,
-- event = "BufReadPre",
-- event = "BufReadPost",
event = "VeryLazy",
opts = {
options = { try_as_border = true },
},
config = function(_,opts)
    require("mini.indentscope").setup( opts  )
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
            vim.b.miniindentscope_disable = true
        end,
    })
end,
},                           

}
