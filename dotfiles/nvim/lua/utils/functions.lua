local M = {}

local function is_valid_buffer(buffer)
  return vim.api.nvim_buf_get_option(buffer, 'buflisted')
end

local function get_valid_buffers()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if is_valid_buffer(buf) then buffers[#buffers + 1] = buf end
  end
  return buffers
end

function M.jump_right()
  -- getpos() -> [bufnum, lnum, col, off]
  local pos = vim.fn.getpos('.')
  pos[3] = string.find(vim.fn.getline('.'), '[%)%]}>]', pos[3] + 1)
  if pos[3] then vim.fn.setpos('.', pos) end
end

function M.reverse_lines()
  local s = vim.fn.line("'<")
  local e = vim.fn.line("'>")
  local reversed_lines = vim.fn.reverse(vim.fn.getline(s, e))
  vim.fn.setline(s, reversed_lines)
end

function M.select_buffer(index)
  vim.api.nvim_set_current_buf(get_valid_buffers()[index])
end

function M.delete_buffer()
  local curbuf = vim.api.nvim_get_current_buf()
  if not is_valid_buffer(curbuf) then return end
  local name = vim.fn.expand("%:t")

  local buffers = get_valid_buffers()
  if #buffers == 1 then
    local newbuf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_set_current_buf(newbuf)
    vim.api.nvim_buf_delete(curbuf, {force = true, unload = false})
  else
    local next_index
    for i = 1, #buffers do
      if buffers[i] == curbuf then
        if i == #buffers then
          next_index = i - 1
        else
          next_index = i + 1
        end
        break
      end
    end
    vim.api.nvim_set_current_buf(buffers[next_index])
    vim.api.nvim_buf_delete(curbuf, {force = true, unload = false})
  end
  print('Closed ' .. name)
end

return M
