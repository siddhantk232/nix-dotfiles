local lsp = require "lsp-zero"

lsp.preset "recommended"

lsp.set_preferences {
  set_lsp_keymaps = false,
}

lsp.ensure_installed {
  "tsserver",
  "eslint",
  "rust_analyzer",
  "clangd",
  "gopls",
  "pyright",
  "bashls",
  "jsonls",
  "svelte",
  "cssls",
  "html",
  "texlab",
  "lua_ls",
}

local cmp = require "cmp"
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm { select = true },
  ["<C-Space>"] = cmp.mapping.complete(),
}

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp {
  mapping = cmp_mappings,
}

lsp.set_preferences {
  suggest_lsp_servers = false,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
}

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  if client.name == "eslint" then
    vim.cmd.LspStop "eslint"
    return
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end

  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lsh", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>lrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
end)

require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require'lspconfig'.rust_analyzer.setup { 
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true, },
        },
    },
}

lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}
