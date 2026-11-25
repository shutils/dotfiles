return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { "<leader>e", "<cmd>Neotree reveal=true<CR>", desc = "Focus Explorer" },
      { "<leader>E", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
      { "<C-S-b>", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
    },
    config = {
      close_if_last_window = true,
      window = {
        mappings = {
          ["l"] = { "open" },
          ["h"] = { "close_node" },
          ["/"] = { "noop" },
        },
      },
    },
  },
}
