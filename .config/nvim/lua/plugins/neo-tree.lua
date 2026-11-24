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
      { "<leader>b", "<cmd>Neotree close<CR>", desc = "Close Explorer" },
    },
    config = {
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
