local M = {}

-- mapper('n', '<c-k>', '<cmd> lua vim.lsp.buf.signature_help()<CR>')
M.mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

return M
