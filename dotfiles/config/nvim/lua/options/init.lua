vim.cmd('filetype plugin indent on') -- set different indent levels based on filetype
vim.o.shortmess = vim.o.shortmess .. 'c' -- Avoid HIT ENTER prompts
vim.o.hidden = true -- helps with buffers
vim.o.whichwrap = 'b,s,<,>,[,],h,l' -- automatically go to the next or previous line when l or h is pressed if the cursor is at the end of line
vim.o.pumheight = 10 -- popup menu height
vim.o.fileencoding = 'utf-8' -- set file encoding to utf-8
vim.o.cmdheight = 2 -- make the bottom section taller
vim.o.splitbelow = true -- automatically open new horizontal splits at the bottom
vim.o.splitright = true -- automatically open new vertical splits at the right
vim.opt.termguicolors = true -- more colors
vim.o.conceallevel = 0 -- stop hiding symbols in markdown and json
vim.o.showtabline = 2 -- show tabs and buffers on top
vim.o.showmode = false -- don't show the current mode at the bottom
vim.o.backup = false -- don't create backupfiles
vim.o.writebackup = false -- disable backups
vim.o.updatetime = 300 -- for some plugins
vim.o.timeoutlen = 100 -- which key time out
vim.o.clipboard = "unnamedplus" -- use system clipboard
vim.o.hlsearch = false -- disable highlighting search results
vim.o.ignorecase = true -- case insensitive search
vim.o.scrolloff = 3 -- automatically scroll down or up if the cursor is 3 lines below or above the end of the file
vim.o.sidescrolloff = 5 -- idk if this works or not
vim.o.mouse = "a" -- enable mouse support
vim.wo.wrap = false -- disable text wrap
vim.wo.number = true -- add line numbers
vim.o.cursorline = true -- highlight the line the cursor is on
vim.wo.signcolumn = "yes" -- signcolumn for lsp symbols or git signs
-- set tabs to 2 spaces
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- some more indentation stuff
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true


