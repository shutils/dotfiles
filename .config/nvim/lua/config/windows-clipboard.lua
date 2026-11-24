if vim.fn.has("wsl") ~= 1 then
  return
end

local clip = vim.fn.exepath("clip.exe")
if clip == "" then
  clip = "/mnt/c/Windows/System32/clip.exe"
end
if vim.fn.executable(clip) ~= 1 then
  return
end
local copy = { vim.fn.resolve(clip) }

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("WindowsClipboardYank", { clear = true }),
  desc = "Copy yanked text to the Windows clipboard",
  callback = function()
    local event = vim.v.event
    if event.operator ~= "y" then
      return
    end

    local text = table.concat(event.regcontents, "\r\n")
    if event.regtype == "V" then
      text = text .. "\r\n"
    end

    local ok, result = pcall(function()
      local utf16 = assert(vim.iconv(text, "utf-8", "utf-16le"))
      return vim.system(copy, { stdin = utf16 }):wait()
    end)
    if not ok or result.code ~= 0 then
      vim.notify("Windows clipboard copy failed", vim.log.levels.WARN)
    end
  end,
})
