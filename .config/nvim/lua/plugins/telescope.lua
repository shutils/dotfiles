return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but recommended
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
      { "<leader>fp", "<cmd>Telescope builtin<CR>", desc = "Telescope builtin" },
    },
  },
}
