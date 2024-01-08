-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
-- Set encoding
vim.o.encoding="UTF-8"
vim.o.fileencoding="UTF-8"
vim.o.fileencodings="UTF-8,iso-2022-jp,euc-jp,sjis"
vim.o.fileformats="unix,dos,mac"

-- Set language
vim.env.LANG="en_US.UTF-8"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.guifont="Cascadia Mono:h12"
-- Check if $TERM is not xterm, then set custom color escape sequences
if vim.fn.exists('$TERM') and vim.env.TERM ~= 'xterm' then
  -- Set text color escape sequence
  vim.o.t_8f = string.format('\27[38;2;%d;%d;%dm', 0, 0, 0) -- Change 0, 0, 0 to your desired text color

  -- Set background color escape sequence
  vim.o.t_8b = string.format('\27[48;2;%d;%d;%dm', 255, 255, 255) -- Change 255, 255, 255 to your desired background color
end

-- vim: ts=2 sts=2 sw=2 et
