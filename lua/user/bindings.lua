
local map = lvim.builtin.which_key.mappings;

-- 下面这几个是能用的
-- map["<leader>ta"] = {"<cmd>let @+=expand('%:p')<cr>", "current file path" }
-- map["<leader>tr"] = { "<cmd>Telescope lsp_references<cr>", "Telescope references" }
-- map["<leader>ti"] = { "<cmd>Telescope lsp_implementations<cr>", "Telescope references" }
-- map["<leader>tf"] = { "<cmd>HopWord<cr>", "HopWord" }

-- map["<leader>tv"] = {"<C-w>v", "水平"} --水平新增窗口
-- map["<leader>th"] = {"<C-w>s", "垂直"} --垂直新增窗口

local keymap = vim.keymap.set
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", {desc = "peek_definition"})


keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {desc = "rename"})
keymap("n", "<leader>tv", "<C-w>v", {desc = "vertical split"}) --水平新增窗口
keymap("n", "<leader>th", "<C-w>s", {desc = "horizontal split"}) --垂直新增窗口
keymap("n", "<leader>tf", "<cmd>HopWord<cr>", {desc = "HopWord"}) -- 查询
keymap("n", "<leader>ta", "<cmd>let @+=expand('%:p')<cr>", {desc = "current file path"}) -- 当前 file path
keymap("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", {desc = "Telescope references"})
keymap("n", "<leader>ti", "<cmd>Telescope lsp_implementations<cr>", {desc = "Telescope lsp_implementations"})
-- 切换 buffer
-- keymap("n", "<C-S-L>", ":bnext<CR>")
-- keymap("n", "<C-S-H>", ":bprevious<CR>")
-- keymap("n", "<leader>q", ":bdelete<CR>")

local whichkey = lvim.builtin.which_key.mappings
-- whichkey.s.l = { "<CMD>Telescope resume<CR>", "Last" }
whichkey.s.s = { "<CMD>SearchSession<CR>", "Sessions" }
whichkey.s.u = { "<CMD>Telescope grep_string<CR>", "Text under cursor" }

whichkey.u = { "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>", "Undo tree" }

whichkey.x = { "<CMD>qa<CR>", "Exit vim" }
whichkey.W = { "<cmd>noautocmd w<cr>", "Save without formatting" }

-- rename
whichkey.s.n = { "<CMD>Lspsaga rename<CR>", "rename" }


-- whichkey.t.a = { "<CMD>let @+=expand('%:p')<CR>", "current file path" }
-- whichkey.t.w = { "<CMD>HopWord<CR>", "HopWord" }
-- whichkey.t.r = { "<CMD>Telescope lsp_references<CR>", "Telescope references" }
-- whichkey.t.i = { "<CMD>Telescope lsp_implementations<CR>", "Telescope lsp_implementations" }
-- whichkey.t.v = { "<C-w>v", "vertical split" }
-- whichkey.t.h = { "<C-w>s", "horizontal split" }

