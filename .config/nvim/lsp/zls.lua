---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = {
  'build.zig',
    '.git',
  },
  settings = {
    zls = {
      -- Using Ruff's import organizer
      -- Whether to enable build-on-save diagnostics (true by default)
      enable_build_on_save = true,
      -- Path to the Zig executable if ZLS can't find it
      -- zig_exe_path = '/path/to/your/zig_executable',
      -- Other ZLS-specific settings can be added here
      -- For example, to control inlay hints:
      inlay_hints = {
          parameter_hints = true,
          type_hints = true,
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   vim.api.nvim_create_autocmd("LspAttach",{
  --       callback = function(args)
  --           vim.keymap.set("n", "K", vim.lsp.buf.hover, args)       -- Hover info
  --       end
  --   })
  --
  --
  -- end,
}
