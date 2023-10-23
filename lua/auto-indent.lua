local module = require("auto-indent.module")

---@class Config
---@field lightmode boolean
---@field indentexpr nil | fun(lnum: integer): integer
local config = {
  lightmode = true,
  indentexpr = nil,
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
  if args and args.indentexpr and type(args.indentexpr) ~= "function" then
    args.indentexpr = nil
    vim.print("auto-indent.nvim: indentexpr should be a function, fallback to use vim.o.indentexpr")
  end
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.check_indent = function()
  local win, buf, row, col = module.get_current_win_buf_pos()

  local indent_char = vim.api.nvim_buf_get_option(buf, "expandtab") and " " or "\t"
  local indent_num = vim.api.nvim_buf_get_option(buf, "tabstop")
  local indents = module.get_current_line_indent(buf, row, M.config.indentexpr)

  module.put_chars(indent_char, indent_num, indents, col)
end

M.check_indent_light = function()
  local win, buf, row, col = module.get_current_win_buf_pos()

  if module.indent_info_tbl[buf] == nil then
    vim.print("TODO: fallback")
    return
  end
  local indent_char = module.indent_info_tbl[buf].indent_char
  local indent_num = module.indent_info_tbl[buf].indent_num
  local indents = module.get_current_line_indent_light(buf, row)

  module.put_chars(indent_char, indent_num, indents, col)
end

return M
