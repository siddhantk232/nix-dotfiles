local nvim_lsp = require("lspconfig")

local mapper = require("siddhant.utils").mapper
local on_attach_vim_plus_keymaps =
    require("siddhant.lsp.custom_attach").on_attach_lsp

-- setup flutter
-- require("siddhant.lsp.flutter")

-- setup compe
require("siddhant.lsp.compe")

local servers = {
  tsserver = {},
  gopls = {},
  clangd = {root_dir = function() return vim.loop.cwd() end},
  hls = {cmd = {"haskell-language-server-8.10.5", "--lsp"}},
  dartls = {},
  solargraph = {},
  pyright = {},
  terraformls = {},
  bashls = {},
  jsonls = require("siddhant.lsp.json").config,
  svelte = require("siddhant.lsp.svelte").config,
  cssls = {cmd = {"vscode-css-language-server", "--stdio"}},
  html = {cmd = {"vscode-html-language-server", "--stdio"}},
  texlab = {}
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = nvim_lsp[name]
    client.setup(vim.tbl_extend("force", {
      flags = {debounce_text_changes = 150},
      on_attach = servers[name].on_attach or on_attach_vim_plus_keymaps
    }, opts))
  end
end
