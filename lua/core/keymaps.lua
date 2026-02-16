local keymap = vim.keymap

-- ============================================================================
-- CHYTRÉ SPUŠTĚNÍ KÓDU (F9)
-- ============================================================================
local function run_code()
    -- 1. Nejdříve soubor uložíme
    vim.cmd("write")

    -- 2. Zjistíme typ souboru
    local ft = vim.bo.filetype
    local file = vim.fn.expand("%") -- Název aktuálního souboru (např. main.c)
    local no_ext = vim.fn.expand("%:r") -- Název bez přípony (např. main)
    
    -- 3. Příkaz pro terminál (zde si to můžeš libovolně měnit)
    local cmd = ""

    if ft == "python" then
        -- Python: spustí skript
        cmd = "python3 " .. file

    elseif ft == "c" then
        -- C: Pokud existuje Makefile, použije tvůj příkaz. Jinak jen gcc.
        if vim.fn.filereadable("Makefile") == 1 then
            cmd = "make clean && make run"
        else
            -- Rychlý compile & run pro jeden soubor (bez Makefile)
            cmd = "gcc " .. file .. " -o " .. no_ext .. " && ./" .. no_ext
        end

    elseif ft == "cpp" then
         if vim.fn.filereadable("Makefile") == 1 then
            cmd = "make clean && make run"
        else
            cmd = "g++ " .. file .. " -o " .. no_ext .. " && ./" .. no_ext
        end

    elseif ft == "lua" then
        cmd = "lua " .. file
        
    elseif ft == "sh" then
        cmd = "bash " .. file

    else
        print("Nevím, jak spustit typ: " .. ft)
        return
    end

    -- 4. Otevření terminálu s příkazem
    -- 'sp' = split (horizontálně), 'term' = terminál
    -- 'resize 15' = nastaví výšku okna na 15 řádků
    vim.cmd("split | resize 15 | term " .. cmd)
    
    -- Přepnutí do Insert módu v terminálu, aby šlo hned psát (pokud program čeká na vstup)
    vim.cmd("startinsert")
end

-- Mapování F9 na naši novou funkci
keymap.set("n", "<F9>", run_code, { desc = "Spustit/Kompilovat kód" })
keymap.set("i", "<F9>", function() 
    vim.cmd("stopinsert") -- Vypne insert mód
    run_code() 
end, { desc = "Spustit/Kompilovat kód" })

-- ============================================================================
-- OSTATNÍ ZKRATKY (Původní)
-- ============================================================================
keymap.set("v", "<C-C>", '"+y', { silent = true })

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Skok do okna vlevo" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Skok do okna dolů" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Skok do okna nahoru" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Skok do okna vpravo" })

-- Zkratky pro NvimTree a Bufferline (z minulých kroků)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Strom projektu" })
keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Další záložka" })
keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Předchozí záložka" })
keymap.set("n", "<leader>c", ":bdelete<CR>", { desc = "Zavřít záložku" })
