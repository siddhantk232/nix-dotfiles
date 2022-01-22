local mapper = require("siddhant.utils").mapper

local M = {}

M.on_attach_lsp = function(client)
  -- mapper('n' , '1gD'         , '<cmd> lua vim.lsp.buf.type_definition()<CR>')
  -- mapper('n' , '<c-]>'       , '<cmd> lua vim.lsp.buf.definition()<CR>')
  mapper('n'    , 'g0'          , '<cmd> lua vim.lsp.buf.document_symbol()<CR>')
  mapper('n'    , 'gD'          , '<cmd> lua vim.lsp.buf.implementation()<CR>')
  mapper('n'    , 'gW'          , '<cmd> lua vim.lsp.buf.workspace_symbol()<CR>')
  mapper('n'    , 'K'           , '<cmd> lua vim.lsp.buf.hover()<CR>')
  mapper('n'    , '<leader>ld'  , '<cmd> lua vim.lsp.buf.definition()<CR>')
  mapper('n'    , '<leader>lca' , '<cmd> lua vim.lsp.buf.code_action()<CR>')
  mapper('n'    , '<leader>lsh' , '<cmd> lua vim.lsp.buf.signature_help()<CR>')
  mapper('n'    , '<leader>lrn' , '<cmd> lua vim.lsp.buf.rename()<CR>')
  mapper('n'    , '<leader>h'   , '<cmd> lua vim.diagnostic.open_float()<CR>')
  mapper('n'    , 'lsd'         , '<cmd> lua vim.lsp.buf.show_line_diagnostics()<CR>')
end

return M
