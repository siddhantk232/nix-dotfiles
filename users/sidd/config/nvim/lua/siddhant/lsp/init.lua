local nvim_lsp = require("lspconfig")

-- setup flutter
-- require("siddhant.lsp.flutter")

-- setup compe
require("siddhant.lsp.cmp")

local servers = {
  tsserver = {},
  gopls = {},
  clangd = {root_dir = function() return vim.loop.cwd() end},
  hls = {},
  dartls = {},
  solargraph = {},
  pyright = {},
  terraform_lsp = {},
  bashls = {},
  jsonls = require("siddhant.lsp.json").config,
  svelte = require("siddhant.lsp.svelte").config,
  cssls = {cmd = {"vscode-css-language-server", "--stdio"}},
  html = {cmd = {"vscode-html-language-server", "--stdio"}},
  texlab = {}
}

local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach_vim_plus_keymaps =
    require("siddhant.lsp.custom_attach").on_attach_lsp


for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = nvim_lsp[name]
    client.setup(vim.tbl_extend("force", {
      flags = {debounce_text_changes = 150},
      on_attach = servers[name].on_attach or on_attach_vim_plus_keymaps,
      capabilities = servers[name].capabilities or cmp_capabilities,
    }, opts))
  end
end
