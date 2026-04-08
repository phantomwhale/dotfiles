-- Utility functions for LSP
local M = {}

---Finds the first executable command from a list of commands.
---Uses vim.fn.executable() for instant PATH lookup instead of running each command.
---@param commands table[] List of command objects with 'cmd' (string[]) property
---@return string[] First command whose binary is in PATH, or the last entry as fallback
function M.check_executable(commands)
  for _, item in ipairs(commands or {}) do
    if vim.fn.executable(item.cmd[1]) == 1 then
      return item.cmd
    end
  end

  return commands[#commands].cmd
end

return M
