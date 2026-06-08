-- Simulates a script run as: lua standalone.lua (from its own directory)
-- package.path must be set by the caller to find import.lua
local import = require('import')
local m = import('./sibling')
assert(m ~= nil, 'import failed: got nil')
assert(m.name == 'sibling', 'wrong name: ' .. tostring(m.name))
print('OK')
