-- ~/.config/nvim/lua/plugins/ai.lua
return {
	{
		"David-Kunz/gen.nvim",
		keys = {
			{ "<leader>aa", ":Gen<CR>", mode = { "n", "v" }, desc = "AI Menu" },
			{ "<leader>ac", ":Gen Chat<CR>", mode = "n", desc = "AI Chat" },
			{ "<leader>ae", ":Gen Vysvětli_kód<CR>", mode = "v", desc = "AI Vysvětlení" },
			{ "<leader>ag", ":Gen Generate<CR>", mode = { "n", "v" }, desc = "AI Generate" },
			{
				"<leader>am",
				function()
					require("gen").select_model()
				end,
				mode = "n",
				desc = "AI Select Model",
			},
		},
		config = function()
			require("gen").setup({
				model = "qwen3-coder-next",
				host = "localhost",
				port = "11434",
				display_mode = "float",
				show_prompt = true,
				show_model = true,
				quit_map = "q",
			})
		end,
	},
}
