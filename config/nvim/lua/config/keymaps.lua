-- Keymaps

-- Up/down keys move up/down through wrapped lines.
vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("v", "<Down>", "gj")
vim.keymap.set("v", "<Up>", "gk")
