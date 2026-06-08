require('busted')

local import = require('import')

describe('lua-import deep', function()
  it('should import 2 levels up then into underscore subfolder', function()
    local m = import('../../_subdir/module')
    assert.no.Nil(m)
    assert.Equal(m.name, '_subdir_module')
  end)

  it('should import 2 levels up then into underscore subfolder with dot notation', function()
    local m = import('../../_subdir.module')
    assert.no.Nil(m)
    assert.Equal(m.name, '_subdir_module')
  end)

  it('should import 2 levels up then into underscore folder via init.lua', function()
    local m = import('../../_subdir')
    assert.no.Nil(m)
    assert.Equal(m.name, '_subdir')
  end)
end)
