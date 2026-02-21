-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    -- Conform (Formátování)
    {
        "stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        keys = {
            { "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "n", desc = "Formatovat" },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                -- python = { "ruff_fix", "ruff_format" },
                python = { "autopep8" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                bash = { "shfmt" },
            },

            formatters = {
                autopep8 = {
                    args = { "--max-line-length", "100" },
                },
            },
        },
    },

    -- LSP & Mason & Autocomplete
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("mason").setup()
            local cmp = require("cmp")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Nastavení serverů
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "bashls", "ruff" },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({ capabilities = capabilities })
                    end,
                    ["ruff"] = function()
                        require("lspconfig").ruff.setup({
                            capabilities = capabilities,
                            on_attach = function(client) client.server_capabilities.hoverProvider = false end,
                        })
                    end,
                },
            })

            -- Autocomplete (CMP)
            cmp.setup({
                snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                }),
                sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" } }, { { name = "buffer" } }),
            })

            -- Zkratky pro LSP (gd, K, atd.)
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })
        end,
    },
}
