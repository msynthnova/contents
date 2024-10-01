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
vim.opt.background = "dark"

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("v", ">", ">gv^", opts)
keymap("v", "<", "<gv^", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Define highlight groups for different modes
vim.api.nvim_set_hl(0, 'StatusLineNormal', { fg = '#ffffff', bg = '#005f5f' })
vim.api.nvim_set_hl(0, 'StatusLineInsert', { fg = '#ffffff', bg = '#5f00af' })

-- Set initial color (normal mode)
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#005f5f' })

-- Autocommands to change status line color based on mode
vim.api.nvim_create_augroup('ModeColor', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'ModeColor',
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#5f00af' })
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'ModeColor',
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#005f5f' })
  end,
})
