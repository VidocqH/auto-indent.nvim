vim.api.nvim_create_user_command("MyFirstFunction", require("auto-indent").check_indent, {})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(e)
    ---@type number
    local buf = e.buf
    -- require("auto-indent.module").fetch_buf_indent_info(buf)
    vim.keymap.set("i", "<tab>", function()
      -- require("auto-indent").check_indent_light()
      require("auto-indent").check_indent()
    end, { buffer = buf })
  end,
})
