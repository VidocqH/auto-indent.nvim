# AutoIndent.nvim

A simple util providing auto indent when cursor at the first column and press <tab> like VSCode

https://github.com/VidocqH/auto-indent.nvim/assets/16725418/b0eda63f-9b7d-4708-8477-00bde49d8f40


## Installation

### Lazy

```lua
requir("lazy").setup({
  {
    'vidocqh/auto-indent.nvim',
    opts = {},
  },
})
```

## Configuration

### Default Config

```lua
{
  lightmode = true,    -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
  indentexpr = nil,    -- Use vim.bo.indentexpr by default
}
```

### Custom Indent Evaluate Method

`indentexpr` should be a function returns a number of indents

example using [treesitter.indent](https://github.com/nvim-treesitter/nvim-treesitter#indentation) module

```lua
{
  ---@param lnum: number
  ---@return number
  indentexpr = function(lnum)
    return require("nvim-treesitter.indent").get_indent(lnum)
  end
}
```
