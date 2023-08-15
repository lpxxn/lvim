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
     },
    { -- % jumps
      "andymass/vim-matchup",
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
      event = "User FileOpened",
    },
    { -- tree with undo history
      "mbbill/undotree",
      cmd = "UndotreeToggle",
    },
}