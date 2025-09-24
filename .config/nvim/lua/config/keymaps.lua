-- visu,al line
local M = {}

function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap  -- Toggle the 'wrap' option.

  local buf = vim.api.nvim_get_current_buf()
  if vim.wo.wrap then
    vim.notify("Text wrapping enabled", vim.log.levels.INFO)
    -- Set keymaps when wrapping is enabled
    vim.keymap.set({"n", "x"}, "j", "gj", { desc = "Move down wrapped line", buffer=buf })
    vim.keymap.set({"n", "x"}, "k", "gk", { desc = "Move up wrapped line", buffer=buf })
    vim.keymap.set("i", "<Down>", "<C-\\><C-o>gj", { desc = "Move down wrapped line", buffer=buf })
    vim.keymap.set("i", "<Up>", "<C-\\><C-o>gk", { desc = "Move up wrapped line", buffer=buf })
  else
    vim.notify("Text wrapping disabled", vim.log.levels.INFO)
    -- Delete keymaps when wrapping is disabled
    vim.keymap.del({"n", "x"}, "j", { buffer =buf }) -- Delete the local 'j' keymap
    vim.keymap.del({"n", "x"}, "k", { buffer =buf }) -- Delete the local 'k' keymap
    vim.keymap.del("i", "<Down>", { buffer =buf } )
    vim.keymap.del("i", "<Up>", { buffer =buf })
  end
end

vim.keymap.set({"n", "x"}, "<leader>w", M.toggle_wrap, {desc="Toggle text wrap"})

-- buffer nav
vim.keymap.set('n', "<leader>bl", ":buffers<cr>:b", {desc="List buffers and give a prompt to switch."})
vim.keymap.set('n', "<leader>bn", ":bn<cr>", {desc="Switch to next buffer in the buffer list."})
vim.keymap.set('n', "<leader>bp", ":bp<cr>", {desc="Switch to previous buffer in the buffer list."})
vim.keymap.set('n', "<leader>bw", ":bw<cr>", {desc="Wipe out current buffer."})

-- Oil
vim.keymap.set('n', "<leader>o", ":Oil<cr>", {desc="Launch OIL file manager", silent=true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope search files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
