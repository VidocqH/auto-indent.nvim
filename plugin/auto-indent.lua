vim.api.nvim_create_user_command("AutoIndentGetIndents", require("auto-indent").check_indent, {})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(e)
    local config = require("auto-indent").config

    local buf = e.buf
    require("auto-indent.module").fetch_buf_indent_info(buf, config.indentexpr)

    vim.keymap.set("i", "<tab>", function()
      -- require("auto-indent").check_indent_light()
      require("auto-indent").check_indent()
    end, { buffer = buf })
  end,
})
