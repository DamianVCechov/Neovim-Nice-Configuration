local keymap = vim.keymap

-- Kompilace a kopírování
keymap.set("n", "<F9>", ":make<CR>", { silent = true })
keymap.set("i", "<F9>", "<Esc>:make<CR>", { silent = true })
keymap.set("v", "<C-C>", '"+y', { silent = true })

-- Rychlý pohyb mezi okny (Ctrl + směr)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Skok do okna vlevo" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Skok do okna dolů" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Skok do okna nahoru" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Skok do okna vpravo" })

-- IDE Strom (Mezerník + e)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Strom projektu" })

-- Záložky (Shift + H/L) a zavírání (Mezerník + c)
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Další záložka" })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Předchozí záložka" })
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { desc = "Zavřít záložku" })
