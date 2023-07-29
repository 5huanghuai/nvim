return{
 
    {
    "tpope/vim-fugitive",
    event = "BufReadPre",
    cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  }, 
    -- single tabpage interface for easily cycling through diffs for all modified files
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
  -- visualise and resolve merge conflicts in neovim
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  -- generate shareable file permalinks (with line ranges) for several git web frontend hosts
  {
    "ruifm/gitlinker.nvim",
    config = true,
  },
      { "junegunn/gv.vim", event = "VeryLazy" },
}
