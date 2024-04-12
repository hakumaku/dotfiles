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
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
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
  local col = string.find(vim.fn.getline('.'), '[%)%]}>"\']', pos[3])
  if col then
    pos[3] = col + 1
    vim.fn.setpos('.', pos)
  end
end

-- Rust stuff

function M.append_semi_colon()
  local line = vim.fn.getline('.')
  if line:sub(-1, -1) ~= ';' then
    vim.fn.setline(vim.fn.line('.'), line .. ';')
  end
end

function M.toggle_eol_await()
  local line = vim.fn.getline('.')
  if line:sub(-1, -1) ~= ';' then
    local col = line:find('.await')
    if col == nil then
      -- let a = expr
      vim.fn.setline(vim.fn.line('.'), line .. '.await;')
    else
      -- let a = expr.await
      vim.fn.setline(vim.fn.line('.'), line .. ';')
    end
  else
    local col = line:find('.await;')
    if col == nil then
      -- let a = expr;
      vim.fn.setline(vim.fn.line('.'), line:sub(1, -2) .. '.await;')
    else
      -- let a = expr.await;
      vim.fn.setline(vim.fn.line('.'), line:sub(1, -8) .. ';')
    end
  end
end

function M.toggle_eol_option()
  local line = vim.fn.getline('.')
  if line:sub(-1, -1) ~= ';' then
    local col = line:find('?')
    if col == nil then
      -- let a = expr
      vim.fn.setline(vim.fn.line('.'), line .. '?;')
    else
      -- let a = expr?
      vim.fn.setline(vim.fn.line('.'), line .. ';')
    end
  else
    local col = line:find('?;')
    if col == nil then
      -- let a = expr;
      print("none, ;")
      vim.fn.setline(vim.fn.line('.'), line:sub(1, -2) .. '?;')
    else
      -- let a = expr?;
      print("await, ;")
      vim.fn.setline(vim.fn.line('.'), line:sub(1, -3) .. ';')
    end
  end
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
  if not is_valid_buffer(curbuf) then
    return
  end
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

function M.get_project_path()
  -- TODO:
end

function M.dap_start()
  -- TODO:
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
