local import_lua_dir = debug.getinfo(1, 'S').source:sub(2):match('(.*)' .. (...):gsub('%.', '/') .. '.lua')

---Converts a path relative to the current directory to realpath relative to root.
--
---@param path string to be resolved
---@param __dirname string of calling script
---@return string
local function resolve_relative(path, __dirname)
  if path:match('^%.%./') then
    local trimmed_path, up_count = path:gsub('%.%./', '')
    local segments = {}
    for str in __dirname:gmatch('([^/]+)') do table.insert(segments, str) end
    for _ = 1, up_count do table.remove(segments) end
    if #segments == 0 then return trimmed_path end
    if #segments == 1 and segments[1] == '' then return trimmed_path end
    if __dirname:match('^/') then table.insert(segments, 1, '') end
    return table.concat(segments, '/') .. '/' .. trimmed_path
  end
  -- when path is relative to current directory
  if path:match('^%./') then return __dirname .. path:gsub('^%./', '') end
  -- when path is doesn't have any relative path
  if path:match('%.') and not path:match('/') then return path end
  -- when path is not relative and contains prefix of __dirname
  if not path:match('%.') and path:match('/') then
    if path:match(__dirname) then return path end
    if path:match(__dirname:gsub('%./', '')) then return path end
  end
  return __dirname .. path
end

---Converts a path to a require argument.
--
---@param path any
---@return string
local function to_require_arg(path) return path:gsub('^%./', ''):gsub('/$', ''):gsub('/', '.') end

---Removes the common root from a string.
---This is the magic method to work when debug.getinfo returns absolute path.
--
---@param s string
---@return string
local function normalise_path(s)
  local to_trim_index = -1
  for i = 1, #import_lua_dir do
    if i > #s then break end
    if s:sub(i, i) == import_lua_dir:sub(i, i) then
      to_trim_index = i
    else
      break
    end
  end
  local to_trim = ''
  if to_trim_index > -1 then to_trim = s:sub(1, to_trim_index) end
  local to_return = s:gsub(to_trim, '')
  return to_return
end

---The lua-import module provides a function,
---the function takes single single string argument which is a glob pattern.
---The return value is the module refered by the glob pattern.
--
---@param path any
---@return unknown
function import(path)
  local __dirname = debug.getinfo(2, 'S').source:sub(2):match('(.*' .. '/' .. ')')
  local resolved_path = resolve_relative(path, __dirname)
  local normal_path = normalise_path(resolved_path)
  local require_arg = to_require_arg(normal_path)
  -- print('import_lua_dir: ' .. import_lua_dir)
  -- print('path: ' .. path)
  -- print('__dirname: ' .. __dirname)
  -- print('resolved_path: ' .. resolved_path)
  -- print('normal_path: ' .. normal_path)
  -- print('require_arg: ' .. require_arg)
  return require(require_arg)
end

print('import_lua_dir: ' .. import_lua_dir)

return import
