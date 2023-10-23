local utils = require("auto-indent.utils")

vim.api.nvim_create_user_command("AutoIndentGetIndents", require("auto-indent").check_indent, {})

vim.api.nvim_create_autocmd("BufRead", {
  callback = function(e)
    local config = require("auto-indent").config

    local buf = e.buf

    if utils.array_contains(config.ignore_filetype, vim.api.nvim_buf_get_option(buf, "filetype")) then
      return
    end

    if config.lightmode then
      require("auto-indent.module").fetch_buf_indent_info(buf, config.indentexpr)
    end

    vim.keymap.set("i", "<tab>", function()
      if config.lightmode then
        require("auto-indent").check_indent_light()
      else
        require("auto-indent").check_indent()
      end
    end, { buffer = buf })
  end,
})
