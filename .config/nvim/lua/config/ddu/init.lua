local keymap = require("config.ddu.keymap")
local param = require("config.ddu.param")
local layout = require("config.ddu.layout")
local start = require("config.ddu.start")
local autocmd = vim.api.nvim_create_autocmd

local function ddu_highlight_setting()
  vim.cmd([[highlight DduRed guifg=red]])
  vim.cmd([[highlight DduLightBlue guifg=lightblue]])
  vim.cmd([[highlight DduYellow guifg=yellow]])
  vim.cmd([[highlight DduGreen guifg=green]])
end

ddu_highlight_setting()

local function ddu_customs_setting()
  vim.fn["ddu#custom#alias"]("source", "ssh", "rg")
  vim.fn["ddu#custom#action"]("source", "ssh", "attach", function(args)
    vim.fn.execute("tabnew | terminal ssh " .. vim.fn.matchstr(args["items"][1]["action"]["text"], "\\s\\(\\S*\\)$"))
    return 0
  end)
  vim.fn["ddu#custom#action"]("source", "tab", "delete", function(args)
    vim.fn.execute(args["items"][1]["action"]["tabnr"] .. "tabclose")
    return 1
  end)
  vim.fn["ddu#custom#action"]("source", "buffer", "delete", function(args)
    local items = args["items"]
    for _, v in ipairs(items) do
      vim.fn.execute("bd! " .. v["action"]["bufNr"])
    end
    return 1
  end)
  vim.fn["ddu#custom#action"]("source", "obsidian_tag", "findNotes", function(args)
    start.obsidian_note(args["items"][1]["action"]["text"])
    return 0
  end)
end

ddu_customs_setting()

local function ddu_global_setting()
  vim.fn["ddu#custom#patch_global"](param.global)
end

ddu_global_setting()

layout.setting()

autocmd("VimResized", {
  pattern = "*",
  callback = layout.setting,
})

keymap.main()

autocmd("FileType", {
  pattern = "ddu-ff",
  callback = keymap.ff,
})

autocmd("User", {
  pattern = "Ddu:ui:ff:openFilterWindow",
  callback = keymap.ff_filter,
})

autocmd("FileType", {
  pattern = "ddu-filer",
  callback = keymap.filer,
})

vim.schedule(function()
  vim.fn["ddu#load"]("ui", { "ff" })
end)
