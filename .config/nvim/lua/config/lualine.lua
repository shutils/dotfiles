local noice = require("noice")

local function runenv()
  if vim.fn.executable("wslpath") == 1 then
    return "wsl"
  end
  if vim.fn.has("win32") == 1 then
    return "Windows"
  end
  return "other"
end

local function virtualenv()
  if vim.env.VIRTUAL_ENV then
    local parts = {}
    for part in vim.env.VIRTUAL_ENV:gmatch("[^/]+") do
      table.insert(parts, part)
    end
    local display = parts[#parts]
    return "  " .. display
  end
  return ""
end

local function cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- For terminal mode
local function skk()
  local mode = vim.fn["skkeleton#mode"]()
  local prev = "A"
  if mode == "hira" then
    prev = "あ"
  elseif mode == "kata" then
    prev = "ア"
  elseif mode == "hankata" then
    prev = "ｱ"
  elseif mode == "zenkaku" then
    prev = "全"
  end

  return "skk:" .. prev
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      "mode",
      {
        noice.api.statusline.mode.get,
        cond = noice.api.statusline.mode.has,
      },
    },
    lualine_b = { "branch", "diff" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { skk, cwd, virtualenv, runenv, "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
