vim.g.mapleader = ","

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>")
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-l>", { silent = true })
vim.keymap.set("n", "H", "gT")
vim.keymap.set("n", "L", "gt")
vim.api.nvim_set_keymap('n', '<leader>u', ':checktime<CR>', { noremap = true, silent = true })
