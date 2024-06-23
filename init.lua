vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "echasnovski/mini.surround", version = "*", config = function() require("mini.surround").setup() end },
  { "nvim-treesitter/nvim-treesitter", config = function() require("nvim-treesitter.configs").setup({ auto_install = true, ensure_installed = { "lua", "vim", "vimdoc", "query" }, highlight = { enable = false }}) end }, 
})

keymap("v", ">", ">gv^", opts)
keymap("v", "<", "<gv^", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

vim.cmd("syntax off")
