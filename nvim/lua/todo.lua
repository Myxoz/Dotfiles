local todo_ns = vim.api.nvim_create_namespace("todo_gutter_signs")

vim.api.nvim_set_hl(0, "TodoDoneSign", { fg = "#00ff00", bold = true })
vim.api.nvim_set_hl(0, "TodoSign", { fg = "#ff0000" })
vim.api.nvim_set_hl(0, "TodoMaybeSign", { fg = "#ffff00" })

local function update_todo_signs()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Clear existing signs in this namespace to avoid duplication
  vim.api.nvim_buf_clear_namespace(bufnr, todo_ns, 0, -1)
  -- Get all lines in the current buffer
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    local line_idx = i - 1 -- Extmarks are 0-indexed
    if line:find("DONE") then
      vim.api.nvim_buf_set_extmark(bufnr, todo_ns, line_idx, 0, {
        sign_text = " ",
        sign_hl_group = "TodoDoneSign",
        priority = 100,
      })
    elseif line:find("TODO") then
      vim.api.nvim_buf_set_extmark(bufnr, todo_ns, line_idx, 0, {
        sign_text = " ",
        sign_hl_group = "TodoSign",
        priority = 100,
      })
    elseif line:find("MAYBE") then
      vim.api.nvim_buf_set_extmark(bufnr, todo_ns, line_idx, 0, {
        sign_text = " ",
        sign_hl_group = "TodoMaybeSign",
        priority = 100,
      })
    elseif line:find("PODO") then
      vim.api.nvim_buf_set_extmark(bufnr, todo_ns, line_idx, 0, {
        sign_text = " ",
        sign_hl_group = "TodoMaybeSign",
        priority = 100,
      })
    end
  end
end

-- Trigger the update automatically on buffer read, text change, and entry
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
  group = vim.api.nvim_create_augroup("TodoGutterGroup", { clear = true }),
  pattern = "*",
  callback = update_todo_signs,
})
