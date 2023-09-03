local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- dependancies
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",

  -- filer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependancies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.neo-tree")
    end,
    event = "VimEnter",
  },

  -- Colorschemes
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
    lazy = false,
    priority = 1000,
  },

  -- Auto Complete
  {
    "hrsh7th/nvim-cmp",
    dependancies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
    },
    config = function()
      require("config.cmp")
    end,
    event = "InsertEnter",
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.luasnip")
    end,
    event = "InsertEnter",
  },

  -- LSP
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    dependancies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.mason")
    end,
    event = "VimEnter",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependancies = {
      "ThePrimeagen/refactoring.nvim",
      "lewis6991/gitsigns.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("config.null-ls")
    end,
  },
  "jay-babu/mason-null-ls.nvim",
  {
    "glepnir/lspsaga.nvim",
    config = function()
      require("config.lspsaga")
    end,
    event = { "LspAttach" },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("config.signature")
    end,
    event = "LspAttach",
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependancies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ghq.nvim",
      "tsakirist/telescope-lazy.nvim",
    },
    config = function()
      require("config.telescope")
    end,
    lazy = true,
    cmd = "Telescope",
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ghq.nvim",
  "tsakirist/telescope-lazy.nvim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.treesitter")
    end,
    build = function()
      vim.cmd([[:TSUpdate]])
    end
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
    event = "VimEnter",
  },
  {
    "sindrets/diffview.nvim",
    dependancies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.diffview")
    end
  },
  {
    "TimUntersberger/neogit",
    dependancies = {
      "sindrets/diffview.nvim",
    },
    config = function()
      require("config.neogit")
    end,
    cmd = "Neogit"
  },
  "tpope/vim-fugitive",

  -- movement
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the cursor
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          -- jump to a remote location to execute the operator
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the search matches
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      }
    },
    config = function()
      require("flash").setup({
        modes = {
          search = {
            enabled = false
          }
        }
      })
    end,
  },

  -- Appearance
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
    event = "VimEnter",
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.devicons")
    end,
    lazy = true,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("config.bufferline")
    end,
    event = "VimEnter",
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("config.nvim-scrollbar")
    end,
    event = "VimEnter",
  },
  {
    "xiyaowong/nvim-cursorword",
    config = function()
      require("config.nvim-cursorword")
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.indent-blankline")
    end
  },
  {
    "folke/todo-comments.nvim",
    dependancies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.todo-comments")
    end
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("config.transparent")
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("config.nvim-notify")
    end
  },
  {
    "folke/noice.nvim",
    dependancies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("config.noice")
    end
  },

  "wellle/targets.vim",
  "tpope/vim-repeat",
  "simeji/winresizer",
  {
    "monaqa/dial.nvim",
    config = function()
      require("config.dial")
    end,
    event = "VimEnter",
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial")
    end,
    event = { "VimEnter" },
  },

  -- ChatGPT
  {
    "shutils/ChatGPT.nvim",
    dependancies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("config.ChatGPT")
    end,
    branch = "customize",
  },

  -- refactoring
  {
    "folke/trouble.nvim",
    dependancies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.trouble")
    end,
    cmd = "TroubleToggle",
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependancies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
  },

  -- utility
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    event = { "VimEnter" },
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
    event = { "VimEnter" },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.toggleterm")
    end,
    event = { "VimEnter" },
  },
  {
    "uga-rosa/translate.nvim",
    config = function()
      require("config.translate")
    end,
    event = { "VimEnter" },
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        map_c_h = true
      })
    end,
    event = { "InsertEnter" },
  }, -- Autopairs, integrates with both cmp and treesitter
  {
    "tyru/open-browser.vim",
    config = function()
      require("config.open-browser")
    end,
    event = { "VimEnter" },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.cmd("!cd app && npm install")
    end,
    -- run this command "call mkdp#util#install"
  },

  "vim-denops/denops.vim",
  "Shougo/ddu-ui-ff",
  "Shougo/ddu-ui-filer",
  "Shougo/ddu-kind-file",
  "Shougo/ddu-kind-word",
  "Shougo/ddu-source-file",
  "Shougo/ddu-source-file_rec",
  "Shougo/ddu-source-file_old",
  "Shougo/ddu-source-register",
  "matsui54/ddu-source-help",
  "matsui54/ddu-source-file_external",
  "matsui54/ddu-source-command_history",
  "tennashi/ddu-source-git",
  "mikanIchinose/ddu-source-markdown",
  "kuuote/ddu-source-git_diff",
  "shun/ddu-source-buffer",
  "shun/ddu-source-rg",
  "Shougo/ddu-filter-matcher_substring",
  "uga-rosa/ddu-filter-converter_devicon",

  -- ddu
  {
    "Shougo/ddu.vim",
    dependancies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-register",
      "matsui54/ddu-source-help",
      "matsui54/ddu-source-file_external",
      "matsui54/ddu-source-command_history",
      "tennashi/ddu-source-git",
      "mikanIchinose/ddu-source-markdown",
      "kuuote/ddu-source-git_diff",
      "shun/ddu-source-buffer",
      "shun/ddu-source-rg",
      "Shougo/ddu-filter-matcher_substring",
      "uga-rosa/ddu-filter-converter_devicon",
    },
    config = function()
      vim.cmd("source ~/.config/nvim/lua/config/ddu.vim")
    end
  },
  "dhruvasagar/vim-table-mode",
}, {
  ui = {
    border = "rounded"
  }
})