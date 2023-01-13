require "siddhant.set"
require "siddhant.remap"
require "siddhant.packer"

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

local autocmd = vim.api.nvim_create_autocmd

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

-- " set filetypes as typescriptreact for syntax highlight
-- autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

-- augroup highlight_yank
--     autocmd!
--     autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
-- augroup END

-- aug i3config_ft_detection
--   au!
--   au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
-- aug end
