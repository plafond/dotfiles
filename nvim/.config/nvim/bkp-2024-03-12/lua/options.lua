vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.background = 'dark'

vim.opt.isfname:append '@-@'
vim.o.updatetime = 300
vim.opt.colorcolumn = '160'
vim.opt.timeoutlen = 1500
vim.opt.ttimeoutlen = 1500

vim.o.termguicolors = true

vim.o.mouse = 'a'
local keymap = vim.keymap -- for conciseness

keymap.set('n', '<leader>pv', vim.cmd.Ex)
---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set('i', 'jk', '<ESC>')

-- clear search highlights
keymap.set('n', '<leader>nh', ':nohl<CR>')

-- delete single character without copying into register
keymap.set('n', 'x', '"_x')

-- increment/decrement numbers
keymap.set('n', '<leader>+', '<C-a>') -- increment
keymap.set('n', '<leader>-', '<C-x>') -- decrement

-- window management
keymap.set('n', '<leader>wv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>wh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>we', '<C-w>=') -- make split windows equal width & height
keymap.set('n', '<leader>wx', ':close<CR>') -- close current split window
---keymap.set("n", "<leader>t", ":term<CR>") -- open a terminal window
keymap.set('n', 'J', 'mzJ`z')
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- undotree
keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
keymap.set('n', '<leader>Y', [["+Y]])

keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- This is going to get me cancelled
keymap.set('i', '<C-c>', '<Esc>')

keymap.set('n', 'Q', '<nop>')
keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
keymap.set('n', '<leader>f', vim.lsp.buf.format)

keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

--use ESC in terminal:
keymap.set('t', '<Esc>', '<C-\\><C-n>')

--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

----------------------
--
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set('n', '<leader>wm', ':MaximizerToggle<CR>') -- toggle split window maximization

-- nvim-tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>') -- toggle file explorer

-- telescope
keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- find files within current working directory, respects .gitignore
keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>') -- find string in current working directory as you type
keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>') -- find string under cursor in current working directory
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>') -- list open buffers in current neovim instance
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>') -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>') -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set('n', '<leader>gfc', '<cmd>Telescope git_bcommits<cr>') -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>') -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<cr>') -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set('n', '<leader>rs', ':LspRestart<CR>') -- mapping to restart lsp if necessary

keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end)
