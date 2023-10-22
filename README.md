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

### Default Config

```lua
{
  lightmode = true    -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
  indentexpr = nil
}
```

### Custom Indent Evaluate Method

```lua
{
  -- lnum: line number
  indentexpr = function (lnum)
    return require("nvim-treesitter.indent").get_indent(lnum)
  end
}
```
