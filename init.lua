-- ~/.config/nvim/init.lua

-- Leader klávesy jako první
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Načtení modulů
require("core.options")
require("core.keymaps")
require("plugins.init") -- Spustí Lazy a načte všechny soubory ve složce plugins
