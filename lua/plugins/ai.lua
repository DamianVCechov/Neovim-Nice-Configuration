-- ~/.config/nvim/lua/plugins/ai.lua
return {
    {
        "David-Kunz/gen.nvim",
        keys = {
            { "<leader>aa", ":Gen<CR>", mode = { "n", "v" }, desc = "AI Menu" },
            { "<leader>ac", ":Gen Chat<CR>", mode = "n", desc = "AI Chat" },
            { "<leader>ae", ":Gen Explain_Code<CR>", mode = "v", desc = "AI Explain" },
            { "<leader>ag", ":Gen Generate<CR>", mode = { "n", "v" }, desc = "AI Generate" },
            { "<leader>ar", ":Gen Refactor_Clean<CR>", mode = { "n", "v" }, desc = "AI Refactor" },
            { "<leader>am", function() require("gen").select_model() end, mode = "n", desc = "AI Select Model" },
        },
        config = function()
            local gen = require("gen")
            
            gen.setup({
                model = "gemma3:1b-it-fp16", 
                host = "localhost",
                port = "11434",
                display_mode = "float", -- nebo "split" či "horizontal-split"
                show_prompt = true,
                show_model = true,
                quit_map = "q",
            })

            -- === VLASTNÍ PROMPTY === --
            
            -- 1. Vysvětlit kód česky (užitečné pro složité funkce)
            gen.prompts["Explain_Code"] = {
                prompt = "Vysvětli následující kód v češtině. Buď stručný a jdi k věci:\n$text",
                replace = false
            }

            -- 2. Generovat Unit Testy
            gen.prompts["Generate_Tests"] = {
                prompt = "Napiš unit testy pro následující kód. Použij standardní testovací framework pro jazyk $filetype. Vypiš pouze kód:\n$text",
                replace = false 
            }

            -- 3. Review kódu / Hledání chyb
            gen.prompts["Review_Code"] = {
                prompt = "Zanalyzuj následující kód ($filetype). Najdi potenciální chyby, bezpečnostní rizika nebo možnosti optimalizace. Odpovídej v bodech:\n$text",
                replace = false
            }

            -- 4. Refaktorizace (nahradí původní kód)
            gen.prompts["Refactor_Clean"] = {
                prompt = "Improve the readability and efficiency of this code. Do not change its functionality. Write only a clean code without markdown:\n$text",
                replace = true, -- Toto nahradí označený text v editoru
                extract = "```$filetype\n(.-)```" -- Regulární výraz pro vytažení kódu z odpovědi
            }
        end,
    },
}
