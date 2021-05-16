local utils = {}

function utils.jump_right()
	-- getpos() -> [bufnum, lnum, col, off]
	local pos = vim.fn.getpos('.')
	pos[3] = string.find(vim.fn.getline('.'), '[%)%]}]', pos[3] + 1)
	vim.fn.setpos('.', pos)
end

return utils
