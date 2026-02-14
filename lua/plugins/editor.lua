-- ~/.config/nvim/lua/plugins/editor.lua
return {
	-- Treesitter (Zvýrazňování syntaxe)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local status_ok, configs = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			require("nvim-treesitter.install").compilers = { "gcc", "clang", "cc" }
			-- Cesta pro parsery (přebírá se z core nastavení, ale pro jistotu zde)
			require("nvim-treesitter.install").parser_install_dir = vim.fn.stdpath("data") .. "/site"

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "make", "bash", "markdown" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Telescope (Vyhledávání)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Najít soubor" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Hledat text" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffery" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Nápověda" })
			vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registry" })
		end,
	},

	-- Oil (Editace souborového systému)
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Otevřít Oil" })
		end,
	},

	-- Comment (Rychlé komentování)
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = true,
	},

    -- HexViex (HexEditor)
	{
		"DamianVCechov/hexview.nvim",
		config = function()
			require("hexview").setup()
		end,
	},
}
