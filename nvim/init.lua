-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ignore version support warning from python lsp
local notify = vim.notify
vim.notify = function(msg, ...)
  if type(msg) == "string" and msg:match("nvim%-lspconfig support for Nvim 0.10") then
    return
  end
  return notify(msg, ...)
end

require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
          require("onedark").setup({ style = "deep" }) -- darker, cool, deep, warm
          require("onedark").load()
        end,
    }, {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "python", "rust", "lua" },
          highlight = { enable = true },
        })
        end,
    },{
        "neovim/nvim-lspconfig",
        config = function()
        require("lspconfig").pylsp.setup({})
        end,
    },
})
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
