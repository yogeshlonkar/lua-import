local import = require('import')

-- This tests importing from a path that goes up two parent directories
-- and then into an underscore-prefixed subfolder
local dumem = import("../../_makina/dumem")
local utils = import("../../_makina.utils")

return {
  dumem = dumem,
  utils = utils
}
