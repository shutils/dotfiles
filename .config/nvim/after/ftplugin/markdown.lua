-- Highlight Markdown and injected languages inside fenced code blocks.
vim.treesitter.start()

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. "|setlocal wrap< linebreak< breakindent<"
  .. "|lua vim.treesitter.stop()"
