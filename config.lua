-- lvim.colorscheme = "slate"
--lvim.colorscheme = "tokyonight"
lvim.colorscheme = "tokyonight-night"

reload("user.plugins")
reload("user.bindings")
reload("user.dapui")
reload("user.symbols-outline")
reload("user.dap")
reload("user.copilot")
reload("user.hop")


lvim.builtin.treesitter.indent = { enable = true, disable = { "go"} }
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go" },
  command = "setlocal autoindent noexpandtab tabstop=4 shiftwidth=4"
})


-- lvim.builtin.which_key.mappings["T"] = {
--     name = "Test",
--     f = { "<cmd>TestFile<cr>", "File" },
--     n = { "<cmd>TestNearest<cr>", "Nearest" },
--     s = { "<cmd>TestSuite<cr>", "Suite" },
--   }
--
--
-- place this in one of your configuration file(s)
