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
    'mattn/calendar-vim',
    lazy = false
},
{
	"gagapony/highlight.nvim",
	event = "VeryLazy",  -- Load when needed
	opts = { }
},
-- {
--     'nvim-tree/nvim-tree.lua',
--     lazy = false,
-- },
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
    dependencies = { 'nvim-treesitter/nvim-treesitter'},            -- if you use the mini.nvim suite
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
	dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
	version = '1.*',
	opts = {
		-- keymap = { preset = 'default' },
		snippets = { preset = 'luasnip' },
		keymap = { preset = 'super-tab' },
		appearance = { nerd_font_variant = 'mono' },
		completion = { documentation = { auto_show = false } },
		-- sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
		sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
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
	"pietropatelli/vim-tex-conceal",
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
  "j-hui/fidget.nvim",
  opts = { },
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

-- nvim-tree
vim.opt.termguicolors = true

-- Luasnip
require("luasnip.loaders.from_snipmate").lazy_load()

local ls = require("luasnip")

vim.keymap.set({"i", "s"}, "<Tab>", function()
    if ls.expand_or_jumpable() then
        return '<Plug>luasnip-expand-or-jump'
    else
        return '<Tab>'
    end
end, { expr = true, silent = true })

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if ls.jumpable(-1) then
        return '<Plug>luasnip-jump-prev'
    else
        return '<S-Tab>'
    end
end, { expr = true, silent = true })

vim.wo.relativenumber = true
vim.wo.cursorline = true

-- vimwiki
-- vim.g.wiki_root = "/path/to/obsidian/vault"

local function find_wiki_path_for_file(filename)
    -- recursively search for the file name in the wiki_root using ripgrep
    local rg_result_pipe = assert(io.popen(string.format(
        "rg -g '%s' --files \"%s\";notify-send 'werks!'",
        filename,
        vim.g.wiki_root
    )))
    local rg_result = rg_result_pipe:read("*line")
    rg_result_pipe:close()

    -- if ripgrep found a result, return that
    if rg_result then return rg_result end

    -- if it didn't find a result, the file does not exist;
    -- in that case, the link will point to the (not yet existing)
    -- corresponding file in the wiki_root
    if vim.g.wiki_root:sub(-1) == "/" then
        return vim.g.wiki_root .. filename
    else
        return vim.g.wiki_root .. "/" .. filename
    end
end

local function resolve_wiki_link(url)
    local components = {}
    for element in (url.stripped .. "#"):gmatch("([^#]*)#") do
        table.insert(components, element)
    end

    local filename = components[1]
    url.anchor = components[2] or ""

    -- infer the .md file extension
    if filename:sub(-3) ~= ".md" then filename = filename .. ".md" end

    if url.origin:sub(1, #vim.g.wiki_root) == vim.g.wiki_root then
        -- if the "origin" (the file that contains the link) is in the wiki_root,
        -- the wiki_root directory is recursively searched for the file name;
        url.path = find_wiki_path_for_file(filename)
    else
        -- if the origin is not in the wiki_root,
        -- fall back to only looking in the same directory as the origin
        url.path = url.origin:match(".*/") .. filename
    end

    return url
end

vim.g.wiki_link_schemes = {
    wiki = { resolver = resolve_wiki_link, },
}

-- treesitter setup
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require("render-markdown").setup({ 
    latex = {
        file_types = { 'markdown', 'vimwiki' },
        -- Turn on / off latex rendering.
        enabled = true,
        -- Additional modes to render latex.
        render_modes = false,
        -- Executable used to convert latex formula to rendered unicode.
        -- If a list is provided the commands run in order until the first success.
        converter = { 'utftex', 'latex2text' },
        -- Render inline latex formulas.
        inline = true,
        -- Render block latex formulas.
        block = true,
        -- Highlight for latex blocks.
        highlight = 'RenderMarkdownMath',
        -- Determines where latex formula is rendered relative to block.
        -- | above  | above latex block                               |
        -- | below  | below latex block                               |
        -- | center | centered with latex block (must be single line) |
        position = 'center',
        -- Number of empty lines above latex blocks.
        top_pad = 0,
        -- Number of empty lines below latex blocks.
        bottom_pad = 0,
    },
})

vim.treesitter.language.register('markdown', 'vimwiki')

-- make main areas transparent
vim.cmd [[highlight Normal guibg=NONE]]
vim.cmd [[highlight StatusLine guibg=NONE]]
vim.cmd [[highlight TabLine guibg=NONE]]
vim.cmd [[highlight TabLineFill guibg=NONE]]
vim.cmd [[highlight SignColumn guibg=NONE]]
vim.cmd [[highlight WinSeparator guibg=NONE]]

-- typst stuff 
vim.cmd.let("g:typst_pdf_viewer='zathura'")

-- sybol-usage
local SymbolKind = vim.lsp.protocol.SymbolKind

---@type UserOpts
require('symbol-usage').setup({
  hl = { link = 'Comment' },
  kinds = { SymbolKind.Function, SymbolKind.Method },
  kinds_filter = {},
  vt_position = 'above',
  vt_priority = nil,
  request_pending_text = 'loading...',
  references = { enabled = true, include_declaration = false },
  definition = { enabled = false },
  implementation = { enabled = false },
  disable = { lsp = {}, filetypes = {}, cond = {} },
  symbol_request_pos = 'end',
  symbol_filter = nil,
  log = { enabled = false },
})
