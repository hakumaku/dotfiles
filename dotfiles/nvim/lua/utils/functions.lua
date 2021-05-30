local M = {}

function M.jump_right()
  -- getpos() -> [bufnum, lnum, col, off]
  local pos = vim.fn.getpos('.')
  pos[3] = string.find(vim.fn.getline('.'), '[%)%]}]', pos[3] + 1)
  vim.fn.setpos('.', pos)
end

function M.reverse_lines()
  local s = vim.fn.line("'<")
  local e = vim.fn.line("'>")
  local reversed_lines = vim.fn.reverse(vim.fn.getline(s, e))
  vim.fn.setline(s, reversed_lines)
end

return M
