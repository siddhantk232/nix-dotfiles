local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. " " .. menu
        end
        vim_item.kind = ""
      end
      vim_item.menu = menu
      return vim_item
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  },

  sources = cmp.config.sources({ { name = "buffer" } }, {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lua" },
    { name = "rg" },
    { name = "calc" },
    { name = "spell" },
    { name = "npm", keyword_length = 3 },
  }),
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
