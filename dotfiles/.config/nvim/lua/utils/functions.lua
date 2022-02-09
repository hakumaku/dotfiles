local M = {}

local function is_valid_buffer(bufnr)
  return vim.api.nvim_buf_get_option(bufnr, 'buflisted')
end

local function get_valid_buffers()
  local valid_buffers = {}
  local buffers = vim.api.nvim_list_bufs()
  for bufnr = 1, #buffers do
    if is_valid_buffer(buffers[bufnr]) then
      valid_buffers[#valid_buffers + 1] = buffers[bufnr]
    end
  end
  return valid_buffers
end

function M.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
    end
    return s .. '}'
  else
    return tostring(o)
  end
end

function M.jump_right()
  -- getpos() -> [bufnum, lnum, col, off]
  local pos = vim.fn.getpos('.')
  local col = string.find(vim.fn.getline('.'), '[%)%]}>"\']', pos[3] + 1)
  if col then
    pos[3] = col
    vim.fn.setpos('.', pos)
  end
end

function M.append_semi_colon()
  local current_line = vim.fn.getline('.')
  vim.fn.setline(vim.fn.line('.'), current_line .. ';')
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

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = true,
    search = vim.fn.input "Grep String > "
  }
end

function M.dap_quit()
  local dap = require("dap")
  dap.disconnect()
  dap.close()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufname(buf) == "[dap-repl]" then
      vim.api.nvim_buf_delete(buf, {force = true, unload = false})
    end
  end
end

return M
