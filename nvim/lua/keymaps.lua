-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim: ts=2 sts=2 sw=2 et

-- set jj >> Esc
vim.keymap.set('i', 'jj', '<ESC>', {silent=true})
-- set C-h >> Nop
vim.keymap.set('i', '<C-h>', '<Nop>', {noremap = true, silent = true})
-- ESC連打でハイライト解除
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>' , {noremap=true})

-- tab command settings
vim.api.nvim_set_keymap('n', '[Tag]', '<Nop>', {noremap=true})
vim.api.nvim_set_keymap('n', 't', '[Tag]', {})
-- tab jump
for n = 1, 9 do
  vim.keymap.set('n', '[Tag]' .. n, ':<C-u>tabnext' .. n .. '<CR>', {silent = true})
end
vim.keymap.set('n','[Tag]c', ':tablast <bar> tabnew<CR>', {})
vim.keymap.set('n','[Tag]x', ':tabclose<CR>' , {})
vim.keymap.set('n','[Tag]n', ':tabnext<CR>', {})
vim.keymap.set('n','[Tag]p', ':tabprevious<CR>', {})
vim.keymap.set('n','[Tag]b', ':tab ba<CR>', {})

-- buffer command settings
vim.keymap.set('n', '<C-j>', ':bnext<CR>', {silent = true})
vim.keymap.set('n', '<C-k>', ':bprevious<CR>', {silent = true})
