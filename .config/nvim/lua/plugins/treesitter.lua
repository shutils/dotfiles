return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- The legacy branch installs pre-generated parsers without tree-sitter-cli.
    branch = "master",
    build = ":TSUpdate",
    ft = { "markdown" },
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
