# ⌨ numberly.nvim

Set the desired line numbering quickly, even if it differs by filetype.

## ✨ Features

- Fast switching among line numbering combinations at will via a hotkey.
- Freely combine absolute/relative line numbering options in ordered sets.
- Ability to use different line numbering sets per filetype.
- Can define a default line numbering set for unknown filetypes.

## ⚡ Requirements

- Neovim 0.5.0

## 💾 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{ 'hsi/numberly.nvim' },
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'hsi/numberly.nvim'
```

### Using [Dein.vim](https://github.com/Shougo/dein.vim)

```vim
call dein#add('hsi/numberly.nvim')
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'hsi/numberly.nvim'
```

## 🚀 Usage

### Per filetype (optional)

The following code makes **numberly** to use both relative and absolute line numberings in Python files after opening them, since `'both'` is the first item in the passed table. Hitting the mapped hotkey (`F6` in the example below) disables any line numbering via the `'none'` setting. Pressing the hotkey again jumps to `'both'` setting, then `'none'`, and so forth.

```lua
-- ~/.config/nvim/after/ftplugin/python.lua
require('numberly').setup({
    'both',
    'none',
})
```

### Default (optional)

It's possible to set a default order of line numberings for unknown filetypes as well. Here when Neovim opens a file without any filetype, the `'none'` setting is activated first. By hitting the hotkey, it'll set relative line numbering only, then absolute line numbering only, and on the third hotkey hit it jumps back to the `'none'` setting, where we started.

```lua
-- ~/.config/nvim/init.lua
require('numberly').setup({
    'none',
    'relative',
    'absolute',
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
