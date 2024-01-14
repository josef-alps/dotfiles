vim.keymap.set('n', '<leader>j', ':Jaq<CR>', { silent = true })
return {
  'is0n/jaq-nvim',
  opts = {
    cmds = {
      internal = {
        lua = "luafile %",
        vim = "source %",
      },
      external = {
        python = "python3 %",
        go = "go run %",
        sh = "sh %",
        ruby = "ruby %",
        java = "java %",
        javascript = "node %",
      },
    },
    behavior = {
      default = "float",
      startinsert = false,
      wincmd = false,
      autosave = false,
    },
    ui = {
      float = {
        border = "none",
        winhl = "Normal",
        borderhl = "FloatBorder",
        winblend = 0,
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
      },
    terminal = {
      position = "bot",
      size = 10,
      line_no = false,
    },
    quickfix = {
      position = "bot",
      size = 10,
    
    },
  },
 },
}
