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
vim.opt.pumheight = 5 -- limit completion items
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("v", ">", ">gv^", opts)
keymap("v", "<", "<gv^", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<S-h>", "<CMD>bprevious<CR>", opts)
keymap("n", "<S-l>", "<CMD>bnext<CR>", opts)
keymap("n", "<leader>t", ":term<CR>", opts)
keymap("n", "<leader>e", ":e .<CR>", opts)
keymap("n", "<leader>l", ":ls<CR>", opts)
keymap("n", "<leader>b", ":b ", opts)
keymap("n", "<leader>d", ":bd ", opts)

-- Define highlight groups for different modes
vim.api.nvim_set_hl(0, "StatusLineNormal", { fg = "#ffffff", bg = "#005f5f" })
vim.api.nvim_set_hl(0, "StatusLineInsert", { fg = "#ffffff", bg = "#5f00af" })

-- Set initial color (normal mode)
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#005f5f" })

-- Autocommands to change status line color based on mode
vim.api.nvim_create_augroup("ModeColor", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    group = "ModeColor",
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#5f00af" })
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = "ModeColor",
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#005f5f" })
    end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {"hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) 
                    end,
                },
                mapping =  {
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            -- Check if Tab was pressed to confirm selection
                            if cmp.get_selected_entry() then
                                cmp.confirm({
                                    select = true,
                                })
                            else
                                fallback()  -- Fallback if no completion is selected
                            end
                        else
                            fallback()  -- Fallback if completion is not visible
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                },
                sources = cmp.config.sources({
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lsp" }
                }),
            })
        end, 
    },
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lsp.clangd.setup {
                capabilities = capabilities,
            }
        end,
    }
},

-- automatically check for plugin updates
checker = { enabled = false },
})

vim.cmd("syntax off")
