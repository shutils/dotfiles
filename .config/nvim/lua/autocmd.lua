local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
if vim.fn.executable("zenhan") then
  autocmd("ModeChanged", {
    pattern = "*:n",
    command = "call system('zenhan 0')",
  })
end

autocmd("TextYankPost", {
  pattern = "*",
  command = ":lua vim.highlight.on_yank {higroup='IncSearch', timeout=300, on_visual=true}",
})

autocmd("QuickfixCmdPost", {
  pattern = "*",
  command = "copen",
})

augroup("YankSetup", { clear = true })
autocmd("VimEnter", {
  group = "YankSetup",
  pattern = "*",
  callback = function()
    -- Use clip.exe for yank if the execution environment is wsl
    if vim.fn.executable("wslpath") == 1 then
      if vim.fn.executable("clip.exe") == 1 and vim.fn.executable("powershell.exe") then
        autocmd("TextYankPost", {
          pattern = "*",
          command = "silent! call system('iconv -t UTF-16LE | clip.exe', @0)",
        })
      else
        vim.notify(
          "Install win32yank.exe if you want to share yanked code to the Windows clipboard. win32yank HP:(https://github.com/equalsraf/win32yank)",
          vim.log.levels.INFO
        )
      end
    else
      if vim.fn.has("win32") then
        vim.api.nvim_command("set clipboard+=unnamedplus")
      end
    end
  end,
})
