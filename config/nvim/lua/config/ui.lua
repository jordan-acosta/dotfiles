-- UI/UX configuration

-- work-around for colorscheme bug introduced in 0.10
-- https://vi.stackexchange.com/questions/45122/why-is-my-terminal-background-color-changing-now-when-i-start-neovim-0-10/45123#45123
-- https://github.com/neovim/neovim/issues/29505
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "NONE", ctermbg = "NONE", ctermfg = "NONE" })

-- Lines
vim.opt.ruler = true
vim.opt.number = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
