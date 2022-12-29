require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
    filetypes = {
      "php",
      "html",
      "xml",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
  },
  context_commentstring = {
    enable = true,
  },
}
