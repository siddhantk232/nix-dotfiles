local mapper = require("siddhant.utils").mapper

mapper("n", "<leader>u", ":UndotreeShow<CR>")
mapper("n", "<leader>e", ":NvimTreeToggle<CR>")
mapper("n", "<Leader><CR>", ":so ~/.config/nvim/init.vim<CR>")

mapper("n", "<Leader>+", ":vertical resize +5<CR>")
mapper("n", "<Leader>-", ":vertical resize -5<CR>")
mapper("n", "<Leader>rp", ":resize 100<CR>")

-- " greatest remap ever
mapper("v", "<leader>p", '"_dP')

-- " next greatest remap ever : asbjornHaland
mapper("n", "<leader>y", '"+y')
mapper("v", "<leader>y", '"+y')
mapper("n", "<leader>Y", 'gg"+yG')

-- PRIME's 2021
mapper("n", "Y", "y$")
mapper("n", "n", "nzzzv")
mapper("n", "N", "Nzzzv")
mapper("n", "J", "mzJ`z")

-- add undo history for ,.!?
mapper("i", ",", ",<c-g>u")
mapper("i", ".", ".<c-g>u")
mapper("i", "!", "!<c-g>u")
mapper("i", "?", "?<c-g>u")

-- move selection around
mapper("v", "J", ":m '>+1<CR>gv=gv")
mapper("v", "K", ":m '<-2<CR>gv=gv")

-- quick fix lists
-- TODO: toggle?
mapper("n", "<C-q>", ":copen<CR>zz")
mapper("n", "<C-j>", ":cprev<CR>zz")
mapper("n", "<C-k>", ":cnext<CR>zz")
mapper("n", "<leader>q", ":lopen<CR>zz")
mapper("n", "<leader>j", ":lprev<CR>zz")
mapper("n", "<leader>k", ":lnext<CR>zz")

-- fugitive
mapper("n", "<leader>gs", ":G<CR>")
mapper("n", "<leader>gd", ":diffget //2")
mapper("n", "<leader>gl", ":diffget //3")
