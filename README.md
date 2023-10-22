# AutoIndent.nvim

A simple util providing auto indent when cursor at the first column and press <TAB>

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

### Configuration

```lua
{
  -- Custom indent evaluate function
  -- lnum: line number
  indentexpr = function (lnum)
    return require("nvim-treesitter.indent").get_indent(lnum)
  end
}
```
