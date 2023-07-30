# ⌨ numberly.nvim

Set the desired line numbering quickly, even if it differs by filetype.

## ✨ Features

- Fast switching among line numbering combinations at will via a hotkey.
- Freely combine absolute/relative line numbering options in ordered sets.
- Ability to use different line numbering sets per filetype.
- Each window respects others' line numbering order for the same buffer too.
- Can define a default line numbering set for unknown filetypes.

## ⚡ Requirements

- Neovim 0.7.0

## 💾 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- ~/.config/nvim/lua/plugins/numberly.lua
return {
    'hsi/numberly.nvim',
    tag = 'stable',
}
```

**or**
```lua
-- ~/.config/nvim/init.lua
{
    'hsi/numberly.nvim',
    tag = 'stable',
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'hsi/numberly.nvim',
    tag = 'stable',
}
```

### Using [dein.vim](https://github.com/Shougo/dein.vim)

```vim
call dein#add('hsi/numberly.nvim', { 'rev': 'stable' })
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'hsi/numberly.nvim', { 'tag': 'stable' }
```

## 🚀 Usage

### Per filetype (optional)

The following code makes **numberly** to use both relative and absolute line numberings in Python files after opening them, since `n.BOTH` is the first item in the passed table. Hitting the mapped hotkey (`F6` in the example below) disables any line numbering via the `n.NONE` setting. Pressing the hotkey again jumps to `n.BOTH` setting, then `n.NONE`, and so forth.

```lua
-- ~/.config/nvim/after/ftplugin/python.lua
local numberly = require('numberly')
local n = numberly.Numberings

numberly.setup({
    n.BOTH,
    n.NONE,
})
```

### Default (optional)

It's possible to set a default order of line numberings for unknown filetypes as well. Here when Neovim opens a file without any filetype, the `n.NONE` setting is activated first. By hitting the hotkey, it'll set relative line numbering only, then absolute line numbering only, and on the third hotkey hit it jumps back to the `n.NONE` setting, where we started.

```lua
-- ~/.config/nvim/init.lua
local numberly = require('numberly')
local n = numberly.Numberings

numberly.setup({
    n.NONE,
    n.RELATIVE,
    n.ABSOLUTE,
})
```

### Key mappings

```lua
-- ~/.config/nvim/init.lua
vim.keymap.set('n', '<F6>', require('numberly').next)
vim.keymap.set('n', '<M-F6>', require('numberly').prev)
```

## ⚖ License

[Apache-2.0](./LICENSE)
