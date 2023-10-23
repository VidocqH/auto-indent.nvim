---@class Utils
local M = {}

---@generic T
---@param arr T[]
---@param val T
---@return boolean
M.array_contains = function(arr, val)
  for _, v in ipairs(arr) do
    if val == v then
      return true
    end
  end
  return false
end

return M
