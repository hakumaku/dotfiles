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

function M.select_buffer(index)
    local all_buffers = vim.api.nvim_list_bufs()
    local buffers = {}
    for _, buf in ipairs(all_buffers) do
        local listed = vim.api.nvim_buf_get_option(buf, 'buflisted')
        if vim.api.nvim_buf_is_loaded(buf) and listed then
            buffers[#buffers+1] = buf
        end
    end
    vim.api.nvim_set_current_buf(buffers[index])
end

return M
