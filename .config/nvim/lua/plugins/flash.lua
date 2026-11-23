return {
  {
    "delphinus/luamigemo",
    lazy = true,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = {
      "delphinus/luamigemo",
    },
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          local migemo = require("luamigemo")

          require("flash").jump({
            search = {
              mode = function(str)
                return migemo.query(str, migemo.RXOP_VIM)
              end,
            },
          })
        end,
        desc = "Flash Japanese Romaji Jump",
      },
    },
  },
}
