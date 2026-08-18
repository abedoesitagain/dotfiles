local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
 if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
   if vim.v.shell_error ~= 0 then
     vim.api.nvim_echo({
       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
       { out, "WarningMsg" },
       { "\nPress any key to exit..." },
     }, true, {})
     vim.fn.getchar()
     os.exit(1)
   end
 end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
{
    'folke/lazy.nvim',
    lazy = false
},
{
    "lmburns/lf.nvim",
    dependencies = 'akinsho/toggleterm.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
},
{
  "windwp/nvim-autopairs",
  lazy = false,
  priority = 1000,
  opts = {},
},
{
    'neovim/nvim-lspconfig'
},
{
  'saghen/blink.cmp',
  -- dependencies = { 'rafamadriz/friendly-snippets' },
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  version = '1.*',
  opts = {
    -- keymap = { preset = 'default' },
    snippets = { preset = 'luasnip' },
    keymap = { preset = 'super-tab' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    -- sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
    sources = { default = { 'lsp', 'path', 'snippets' }, },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
},
{
  'Wansmer/symbol-usage.nvim',
  event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
  config = function()
    require('symbol-usage').setup()
  end
},
{
    "mason-org/mason.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
},
{
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    -- @module 'render-markdown'
    -- @type render.md.UserConfig
    opts = {},
},
{
    "KeitaNakamura/tex-conceal.vim",
    ft = 'latex',
    priority = 1000,
},
{
    "lervag/vimtex",
    ft = 'latex',
    version = '*',
  	lazy = false,
},
{
    "kaarmu/typst.vim",
    ft = 'typst',
    lazy = false,
},
{
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "journal",
        path = "~/docs/journal",
      },
    },

    -- see below for full list of options 👇
  },
},
{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
  }
},
{
  "j-hui/fidget.nvim",
  opts = {
    -- options
  },
},
{
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
},
{
    "NeogitOrg/neogit",
    lazy = false,
    priority = 1000,
    opts = {},
},
{
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp"
}
},
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = true },
})
