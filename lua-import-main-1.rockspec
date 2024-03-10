rockspec_format = '3.0'
package = 'lua-import'
version = 'main-1' -- overwritten by git tag
source = {url = 'git://github.com/yogeshlonkar/lua-import', tag = '0.1.0-1'}
description = {
  summary = 'An import function to require modules with relative pattern',
  detailed = [[
        The lua-import module provides a function.
        The function takes single string argument same as require,
        but the argument can be a relative path to the required module.
        The return value is the module referred by the path argument.
    ]],
  license = 'MIT',
}
dependencies = {'lua >= 5.1', 'busted >= 2.2.0-1'}
test = {
  type = 'busted'
}
build = {type = 'builtin', modules = {['import'] = 'import.lua'}}

