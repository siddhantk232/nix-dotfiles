local actions = require('telescope.actions')
local telescope = require('telescope')

local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = false})
end

telescope.setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {i = {["<C-x>"] = false, ["<C-q>"] = actions.send_to_qflist}}
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      fuzzy = true
    }
  }
}

telescope.load_extension('fzf')

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/.config/nvim/"
  })
end

M.search_vimwiki = function()
  require("telescope.builtin").find_files({
    prompt_title = "< Wiki >",
    cwd = "~/vimwiki/"
  })
end

M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)
      return true
    end
  })
end

-- keymaps

mapper('n', '<leader>ps',
       ':lua require(\'telescope.builtin\').grep_string({ search = vim.fn.input("Grep For > ")})<CR>')

mapper('n', '<C-p>', ':lua require(\'telescope.builtin\').git_files()<CR>')

mapper('n', '<Leader>pf', ':lua require(\'telescope.builtin\').find_files()<CR>')

mapper('n', '<leader>pw',
       ':lua require(\'telescope.builtin\').grep_string { search = vim.fn.expand("<cword>") }<CR>')

mapper('n', '<leader>pb', ':lua require(\'telescope.builtin\').buffers()<CR>')

mapper('n', '<leader>vrc',
       ':lua require(\'siddhant.telescope\').search_dotfiles()<CR>')

mapper('n', '<leader>ww',
       ':lua require(\'siddhant.telescope\').search_vimwiki()<CR>')

mapper('n', '<leader>gc',
       ':lua require(\'siddhant.telescope\').git_branches()<CR>')

mapper('n', '<leader>gh', ':lua require(\'telescope.builtin\').help_tags()<CR>')

return M
