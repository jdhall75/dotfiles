return {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    root_markers = {{'.luarc.json', '.luarc.jsonc'},'.git'},
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }, -- Recognize 'vim' global in Neovim
            },
            -- workspace = {
            --     library = vim.api.nvim_get_runtime_series(''), -- Include Neovim runtime files
            -- },
            runtime = {
                version = 'Lua 5.1', -- Or 'Lua 5.4', etc.
            },
        },
    },
}

