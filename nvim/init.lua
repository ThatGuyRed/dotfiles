-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.termguicolors = true
require("bufferline").setup()
vim.lsp.enable({
  "lua_ls",
  "bashls",
  "clangd",
  "pylsp",
  "omnisharp",
  "oxfmt",
  "sqlls",
  "gopls"
})

require("mason").setup()
require("mason-lspconfig").setup()
