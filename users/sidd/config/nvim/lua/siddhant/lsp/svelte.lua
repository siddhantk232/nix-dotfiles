local M = {}

M.config = {
  filetypes = { "svelte" },
  settings = {
    svelte = {
      plugin = {
        html = { completions = { enable = true, emmet = true } },
        svelte = { completions = { enable = true, emmet = true } },
        css = { completions = { enable = true, emmet = true } },
      },
    },
  },
}

return M
