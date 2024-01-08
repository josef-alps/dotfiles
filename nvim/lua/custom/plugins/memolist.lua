-- Memo List
vim.keymap.set('n', '<Leader>ml', ':Memolist<CR>', { noremap=true})

-- Memo new
vim.keymap.set('n', '<Leader>mn', ':MemoNew<CR>', { noremap=true})

-- Memo grep
vim.keymap.set('n', '<Leader>mg', ':MemoGrep<CR>', { noremap=true})

-- Set memolist_path = "~/.memolist/memo"
vim.g.memolist_path = "~/.memolist/memo"

-- suffix type
vim.g.memolist_memo_suffix = "md"
return {
  "glidenote/memolist.vim"
}
