-- ~/.config/nvim/lua/plugins/init.lua

-- 1. Příprava cest
local site_path = vim.fn.stdpath("data") .. "/site"
vim.opt.rtp:prepend(site_path)

-- 2. Bootstrap Lazy.nvim (Stažení manažeru)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Načtení pluginů z ostatních souborů
require("lazy").setup({
    spec = {
        -- Tímto importujeme ostatní soubory v této složce
        { import = "plugins.ui" },     -- Vzhled (Barvy, Lualine, NvimTree...)
        { import = "plugins.editor" }, -- Editace (Treesitter, Telescope...)
        { import = "plugins.lsp" },    -- Inteligence (LSP, Mason, CMP...)
        { import = "plugins.ai" },     -- AI (Gen.nvim)
    },
    change_detection = {
        notify = false, -- Vypne otravné hlášky při změně konfigurace
    },
})
