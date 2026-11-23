return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown rendering" },
    },
    opts = {
      heading = {
        sign = false,
      },
      code = {
        sign = false,
        width = "block",
        left_pad = 1,
        right_pad = 1,
      },
      -- Keep formulas as source without requiring external converters.
      latex = { enabled = false },
    },
  },
}
