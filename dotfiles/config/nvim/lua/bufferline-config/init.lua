require("bufferline").setup{}
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev', {noremap = true, silent = true})
