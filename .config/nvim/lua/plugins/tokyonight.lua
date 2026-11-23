return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl, colors)
          hl["@markup.strong.markdown_inline"] = { fg = colors.orange, bold = true }
          hl["@markup.italic.markdown_inline"] = { fg = colors.magenta, italic = true }
          hl["@markup.link.label.markdown_inline"] = { fg = colors.cyan, underline = true }
          hl["@markup.link.url.markdown_inline"] = { fg = colors.blue, underline = true }
          hl["@markup.list.markdown"] = { fg = colors.orange, bold = true }
          hl["@markup.quote.markdown"] = { fg = colors.green, italic = true }
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
