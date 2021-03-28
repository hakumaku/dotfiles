local neocmake = {}

-- isdirectory()  check if a directory exists
-- mkdir()        create a new directory
-- getftype()     get the kind of a file
-- findfile()     find a file in a list of directories
-- finddir()      find a directory in a list of directories

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local home = vim.fn.expand('~')
local project_cmake = nil
local project_cmake_settings = nil
local project_dir = nil

-- Search the directory tree upward and return the last CMakeLists.txt.
function find_topmost_cmake(dir)
	local cmakes = vim.fn.findfile('CMakeLists.txt', dir..';'..home, -1) 
	if cmakes == nil then
		return ''
	end

	local root_cmake = cmakes[#cmakes]
	return root_cmake
end

-- Returns a directory containing '.git'.
function find_project_dir(dir)
	local dir = vim.fn.finddir('.git', dir..';'..home)
	if dir == nil then
		return ''
	end

	return dir:gsub(".git", "")
end

-- Returns json contents of config in the given directory.
function read_config(dir)
	local conf = io.open(dir..'.cmake-conf')

	if conf == nil then
		return nil
	end

	local contents = conf:read('*all')
	io.close(conf)

	if contents == '' then
		return nil
	end

	return vim.fn.json_decode(contents)
end

function neocmake.cmake()
	if topmost_cmake == nil then
		local curdir = vim.fn.expand('%:p')
		project_cmake = find_topmost_cmake(curdir)
		project_dir = find_project_dir(curdir)
		local settings = read_config(project_dir)
		if settings ~= nil then
			project_cmake_settings = settings
		end
	end

	print(project_cmake)
	print(project_dir)
	print(dump(project_cmake_settings))
end

return neocmake
