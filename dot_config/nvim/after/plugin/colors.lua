local color_my_pencils = function()
  local line_bg_color = 235
  local line_fg_color = 226
  vim.api.nvim_set_hl(0, 'Comment', {})
  vim.api.nvim_set_hl(0, 'Cursor', { ctermfg = 251 })
  vim.api.nvim_set_hl(0, 'DiffAdd', { fg = '#05fc47', ctermfg = 'lightgreen', bold = true })
  vim.api.nvim_set_hl(0, 'DiffChange', { ctermfg = line_fg_color, bold = true })
  vim.api.nvim_set_hl(0, 'DiffDelete', { ctermfg = 160 })
  vim.api.nvim_set_hl(0, 'DiffText', { ctermfg = 'lightred' })
  vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { ctermbg = line_bg_color })
  vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { ctermbg = line_bg_color })
  vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { ctermbg = line_bg_color })
  vim.api.nvim_set_hl(0, 'Cursorline', { ctermbg = line_bg_color, bg = line_bg_color })
  vim.api.nvim_set_hl(0, 'CursorLineNR', { ctermbg = line_bg_color, ctermfg = line_fg_color, bold = true })
  vim.api.nvim_set_hl(0, 'CursorLineSign', { ctermbg = line_bg_color, bold = true })
end

color_my_pencils()
