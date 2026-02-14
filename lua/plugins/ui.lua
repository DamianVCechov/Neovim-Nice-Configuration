-- ~/.config/nvim/lua/plugins/ui.lua
return {
    -- Barevné schéma TokyoNight
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                on_colors = function(colors) colors.bg = "#000000" end,
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- Lualine (Spodní stavový řádek)
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { options = { theme = "tokyonight" } },
    },

    -- Which-Key (Nápověda zkratek)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },

    -- Nvim-Tree (Boční panel - IDE styl)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width = 35, side = "left" },
                renderer = { group_empty = true },
                filters = { dotfiles = false },
            })
        end,
    },

    -- Bufferline (Horní záložky - IDE styl)
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                mode = "buffers",
                separator_style = "slant",
                always_show_bufferline = true,
                offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center", separator = true } },
            }
        }
    },
}
