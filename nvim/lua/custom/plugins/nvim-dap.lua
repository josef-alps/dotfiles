local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
	  options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local venv = os.getenv('VIRTUAL_ENC')

map("n", "<leader>6", ":lua require'dap'.continue()<CR>", { silent = true })
map("n", "<leader>7", ":lua require'dap'.step_over()<CR>", { silent = true })
map("n", "<leader>8", ":lua require'dap'.step_into()<CR>", { silent = true })
map("n", "<leader>9", ":lua require'dap'.step_out()<CR>", { silent = true })
map("n", "<leader>;", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
map("n", "<leader>'", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
map(
	"n",
	"<leader>i",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ silent = true }
)
map("n", "<leader>d", ":lua require'dapui'.toggle()<CR>", { silent = true })
map("n", "<leader><leader>d", ":lua require'dapui'.eval()<CR>", { silent = true })

return {
  { 'mfussenegger/nvim-dap'},
  { 'rcarriga/nvim-dap-ui'},
  { "suketa/nvim-dap-ruby", config = true, ft = "ruby" },
  { "leoluz/nvim-dap-go", ft = "go" },
  { "mfussenegger/nvim-dap-python", ft = "python" },

  -- nvim-dap-go
  -- { "dap-go",
  --   delve = {
  --     path = "~/.local/share/nvim/mason/packages/delve/dlv",
  --   }
  -- },
  --{ "dap-python",
  --  string.format('%s/bin/python',venv),
  --},
}

