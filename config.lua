lvim.colorscheme = "slate"

lvim.plugins = {
  {"mfussenegger/nvim-dap"},
  { "rcarriga/nvim-dap-ui"},
  {"github/copilot.vim"},
  {"simrat39/symbols-outline.nvim"},
  {
      "vim-test/vim-test",
      cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
      keys = { "<leader>tf", "<leader>tn", "<leader>ts" },
      config = function()
        vim.cmd [[
          function! ToggleTermStrategy(cmd) abort
            call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
          endfunction
          let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
        ]]
        vim.g["test#strategy"] = "toggleterm"
      end,
    },
    {
      "glepnir/lspsaga.nvim",
--      event = "LspAttach",
      config = function()
          require("lspsaga").setup({})
      end,
      dependencies = {
          {"nvim-tree/nvim-web-devicons"},
          --Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
      }
    },
    {
       "folke/trouble.nvim",
       dependencies = { "nvim-tree/nvim-web-devicons" },
       opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
       },
    },{
      'phaazon/hop.nvim',
       branch = 'v2', -- optional but strongly recommended
       config = function()
         -- you can configure Hop the way you like here; see :h hop-config
         require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
       end
     }
}
require("dapui").setup()
require("symbols-outline").setup()


-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4N
--
--
-- local dap = require('dap')
-- dap.adapters.go = function(callback, config)
--   print(config)
--   local stdout = vim.loop.new_pipe(false)
--   local handle
--   local pid_or_err
--   local port = config.delve.port
--   local opts = {
--     stdio = { nil, stdout },
--     args = { "dap", "-l", "127.0.0.1:" .. config.delve.port},
--     detached = true,
--   }

--   handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
--     stdout:close()
--     handle:close()
--     if code ~= 0 then
--       print("dlv exited with code", code)
--     end
--   end)
--   assert(handle, "Error running dlv: " .. tostring(pid_or_err))
--   stdout:read_start(function(err, chunk)
--     assert(not err, err)
--     if chunk then
--       vim.schedule(function()
--         require("dap.repl").append(chunk)
--       end)
--     end
--   end)
--   vim.defer_fn(function()
--     callback { type = "server", host = "127.0.0.1", port = port }
--   end, 100)
-- end;

-- -- 此处获取命令行输入参数，其他语言的配置也是可以加的啦
-- -- 主要是这个程序是一个简单的容器实验，模仿实现docker所以需要从命令行输入参数
local get_args = function()
  -- 获取输入命令行参数
  local cmd_args = vim.fn.input('CommandLine Args:')
  local params = {}
  -- 定义分隔符(%s在lua内表示任何空白符号)
  for param in string.gmatch(cmd_args, "[^%s]+") do
    table.insert(params, param)
  end
  return params
end;

-- dap.configurations.go = {
-- -- 普通文件的debug
--   {
--     type = "go",
--     name = "Debug",
--     request = "launch",
--     args = get_args,
--     program = "${file}",
--   },
-- -- 测试文件的debug
--   {
--     type = "go",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     args = get_args,
--     mode = "test",
--     program = "${file}",
--   },
-- }
--
lvim.builtin.dap.active = true
local dap = require "dap"
  dap.adapters.go = function(callback, config)
    print('config: --: ', config, config.delve)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = {nil, stdout},
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
      100)
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      args = get_args,
      program = "${file}"
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      args = get_args,
      program = "${file}"
    },
    -- works with go.mod packages and sub packages 
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      args = get_args,
      program = "./${relativeFileDirname}"
    } 
}

local map = lvim.builtin.which_key.mappings;

-- map["<F5>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" }
--map['<F5>'] = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"} 
-- map({ "n", "<F9>", ":lua require('dap').continue()<CR>" })

-- map({ "n", "<F1>", ":lua require('dap').step_over()<CR>" })
-- map({ "n", "<F2>", ":lua require('dap').step_into()<CR>" })
-- map({ "n", "<F3>", ":lua require('dap').step_out()<CR>" })

-- map({ "n", "<Leader>dsc", ":lua require('dap').continue()<CR>" })
-- map({ "n", "<Leader>dsv", ":lua require('dap').step_over()<CR>" })
-- map({ "n", "<Leader>dsi", ":lua require('dap').step_into()<CR>" })
-- map({ "n", "<Leader>dso", ":lua require('dap').step_out()<CR>" })

-- map({ "n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>" })
-- map({ "v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>" })

-- map({ "n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>" })
-- map({ "n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>" })

-- map({ "n", "<Leader>dro", ":lua require('dap').repl.open()<CR>" })
-- map({ "n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>" })

-- map({ "n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" })
-- map({ "n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>" })
-- map({ "n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>" })

-- map({ "n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>" })
--map({ "n", "<Leader>di", ":lua require('dapui').toggle()<CR>" })
map["<Leader>di"] = {"<cmd>lua require('dapui').toggle()<cr>", "dapui toggle" }
map["<Leader>ta"] = {"<cmd>let @+=expand('%:p')<cr>", "current file path" }
map["<Leader>tr"] = { "<cmd>Telescope lsp_references<cr>", "Telescope references" }
map["<Leader>ti"] = { "<cmd>Telescope lsp_implementations<cr>", "Telescope references" }
map["<Leader>tf"] = { "<cmd>HopWord<cr>", "HopWord" }

-- map["<Leader>tv"] = {"<C-w>v", "水平"} --水平新增窗口
-- map["<Leader>th"] = {"<C-w>s", "垂直"} --垂直新增窗口

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





lvim.builtin.treesitter.indent = { enable = true, disable = { "go"} }
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go" },
  command = "setlocal tabstop=4 shiftwidth=4"
})

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

-- lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
--   cmp.mapping.abort()
--   local copilot_keys = vim.fn["copilot#Accept"]()
--   if copilot_keys ~= "" then
--     vim.api.nvim_feedkeys(copilot_keys, "i", true)
--   else
--     fallback()
--   end
-- end
--
lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
      fallback()
    end
  end
end


-- lvim.builtin.which_key.mappings["T"] = {
--     name = "Test",
--     f = { "<cmd>TestFile<cr>", "File" },
--     n = { "<cmd>TestNearest<cr>", "Nearest" },
--     s = { "<cmd>TestSuite<cr>", "Suite" },
--   }
--
--
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
