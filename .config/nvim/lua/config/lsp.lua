vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
-- vim.lsp.enable("vimls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_server")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp_config_group', { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end
        if client.name == 'ruff' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
        if client:supports_method("textDocument/completion") then
            vim.opt.completeopt = {'menu', 'menuone', 'noinsert', 'fuzzy', 'popup'}
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
        end
    end,
})

vim.diagnostic.config({
    underline = true,
    virtual_lines = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '⠑',
            [vim.diagnostic.severity.WARN] = '⠺',
            [vim.diagnostic.severity.HINT] = '⠦',
            [vim.diagnostic.severity.INFO] = '⠔',
        },
    },
})

vim.keymap.set('n', 'gK', function()
  if vim.diagnostic.config() and vim.diagnostic.config().virtual_lines then
      vim.diagnostic.config({ virtual_lines = false })
  else
      vim.diagnostic.config({ virtual_lines = { current_line = true } })
  end
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
