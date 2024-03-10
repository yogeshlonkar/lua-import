require('busted')

local import = require('import')

describe('lua-import', function()
  it('should import same as require', function()
    local m = import('spec.unit.fixture_one')
    assert.no.Nil(m)
    assert.is.Equal(m.name, 'fixture_one')
  end)

  it('should import same as require with filepath separator', function()
    local m = import('spec/unit/fixture_one')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_one')
  end)

  it('should import relative to current directory', function()
    local m = import('./fixture_one')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_one')
  end)

  it('should import relative to current directory without filepath separator', function()
    local m = import('fixture_one')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_one')
  end)

  it('should import relative to current directory with init.lua', function()
    local m = import('./fixture_two')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_two')
  end)

  it('should import relative to current directory with init.lua withouth ./', function()
    local m = import('fixture_two/two_dot_one')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_two_dot_one')
  end)

  it('should import relative to parent directory', function()
    local m = import('../fixture_three')
    assert.no.Nil(m)
    assert.Equal(m.name, 'fixture_three')
  end)

  it('should import relative to parent 2 up directory', function()
    local m = import('../../import')
    assert.no.Nil(m)
    assert.Equal(type(m), 'function')
  end)

end)
