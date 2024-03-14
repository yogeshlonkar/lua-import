# lua-import [![License](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE) [![Build Status](https://github.com/yogeshlonkar/lua-import/actions/workflows/on-push.yml/badge.svg)](https://github.com/yogeshlonkar/lua-import/actions)
The lua-import module provides a function.
The function takes single string argument same as require, but the argument can be a relative path to the required module.
The return value is the module referred by the path argument.

## 💻 Install
    
### Using luarocks

``` shell
luarocks install lua-import
```

### Copy/ paste

Copy [import.lua](import.lua) to `lua/` directory in your project.

## 🧑‍💻  Usage 

Add below line to init.lua or entry point of your project

```lua
require('import')
```

### neovim

I use this package in my neovim configuration which was the main inspiration for building this package.
As neovim configuration directories get significantly nested, the require statements on top of some files start looking like horizontal bar chart.

To simplify require statements in neovim configurations:

- Copy [import.lua](import.lua) to `lua/` directory in your neovim configuration.
- Add `require('import')` to `init.lua`.

Then you can use `import` function in of lua files anywhere in your configurations.

## Example

Below is the directory structure of the [tests](spec) in this package, all examples are based on it.

```text
spec
├── fixture_three.lua
└── unit
    ├── fixture_one.lua
    ├── fixture_two
    │   ├── init.lua
    │   └── two_dot_one.lua
    └── import_spec.lua

3 directories, 5 files
```

```lua
-- will import same as require
local m = import('spec.unit.fixture_one')

-- will same as require with filepath separator
local m = import('spec/unit/fixture_one')

-- will import relative to current directory
local m = import('./fixture_one')

-- will import relative to current directory without filepath separator
local m = import('fixture_one')

-- will import relative to current directory with init.lua
local m = import('./fixture_two')

-- will import relative to current directory with init.lua withouth ./
local m = import('fixture_two/two_dot_one')

-- will import relative to parent directory
local m = import('../fixture_three')

-- will import relative to parent 2 up directories
local m = import('../../import')
```

## Development

To setup project for development, run the following commands.

```shell
luarocks install --deps-mode all --only-deps lua-import-0.1.0-1.rockspec
eval "$(luarocks path --bin)"
```

To run the tests

```shell
luarocks test

# or
busted .
```
