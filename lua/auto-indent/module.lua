---@class BufferIndentInfo
---@field indentexpr string
---@field indentchar string
---@field indentnum number
local BII = {
  indentexpr = "",
  indent_char = "\t",
  indent_num = 8,
}

---@class CustomModule
local M = {}

---@type BufferIndentInfo[]
M.indent_info_tbl = {}

---@param bufnr number
M.fetch_buf_indent_info = function(bufnr)
  local indentexpr = vim.api.nvim_buf_get_option(bufnr, "indentexpr")
  local indent_char = vim.api.nvim_buf_get_option(bufnr, "expandtab") and " " or "\t"
  local indent_num = vim.api.nvim_buf_get_option(bufnr, "tabstop")

  M.indent_info_tbl[bufnr] = {
    indentexpr = (indentexpr == nil or indentexpr == "") and "" or string.sub(indentexpr, 1, -3),
    indent_char = indent_char,
    indent_num = indent_num,
  }
end

---@param bufnr number
---@return number
M.get_current_line_indent = function(bufnr)
  local indentexpr = vim.api.nvim_buf_get_option(bufnr, "indentexpr")
  if indentexpr == nil or indentexpr == "" then
    return 0
  end
  indentexpr = string.sub(indentexpr, 1, -3)
  local isSuccess, result = pcall(vim.fn[indentexpr])
  return isSuccess and result or 0
end

---@param bufnr number
---@return number
M.get_current_line_indent_light = function(bufnr)
  local indentexpr = M.indent_info_tbl[bufnr].indentexpr
  if indentexpr == "" then
    return 0
  end
  local isSuccess, result = pcall(vim.fn[indentexpr])
  return isSuccess and result or 0
end

---@param indent_char string
---@param indent_num number
---@param computed_indents number
---@param colnr number
M.put_chars = function(indent_char, indent_num, computed_indents, colnr)
  if colnr ~= 0 then
    vim.api.nvim_put({ string.rep(indent_char, indent_num) }, "c", false, true)
    return
  end
  local put_chars = string.rep(indent_char, computed_indents > 0 and computed_indents or indent_num)

  vim.api.nvim_put({ put_chars }, "c", false, true)
end

---@return number, number, number, number
M.get_current_win_buf_pos = function()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(win)
  local row, col = pos[1], pos[2]
  return win, buf, row, col
end

return M
