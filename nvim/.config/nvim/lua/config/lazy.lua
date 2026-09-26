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
  "gagapony/highlight.nvim",
  event = "VeryLazy",  -- Load when needed
  opts = {
    -- Configuration here (optional)
  }
},
{
    "mattn/emmet-vim",
    lazy = false,
    init = function ()
        vim.g.user_emmet_leader_key = '<C-Y>'
    end,
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
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
},
{
  'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_path = '~/docs/journal/'
    vim.g.vimwiki_syntax = 'markdown'
    vim.g.vimwiki_ext = 'md'
    vim.g.vimwiki_global_ext = 0
  end,
},
{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
},
{
    'neovim/nvim-lspconfig',
    lazy = true,
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
