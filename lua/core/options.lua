local opt = vim.opt

-- Číslování a vzhled
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.ruler = true
opt.showcmd = true
opt.backspace = { "indent", "eol", "start" }

-- Schránka (Clipboard)
opt.clipboard:append("unnamedplus")

-- Odsazování (4 mezery)
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.textwidth = 0

vim.cmd("filetype plugin indent on")

-- Nastavení pro GUI (nvim-qt)
if vim.fn.has("gui_running") == 1 or vim.g.GuiLoaded then
    opt.guifont = "Inconsolata Nerd Font Mono:h12"
end

-- Automatické příkazy (Autocommands)
local augroup = vim.api.nvim_create_augroup("ProjectSettings", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.py", "*.c", "*.h" },
    command = "set expandtab",
    group = augroup,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Makefile", "*.mk" },
    command = "set noexpandtab",
    group = augroup,
})
