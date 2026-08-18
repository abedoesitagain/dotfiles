require("config.lazy")
require("config.lsp")
vim.cmd.set("nu")
vim.cmd.set("clipboard+=unnamedplus")
vim.cmd.syntax("on")
vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("enable")
vim.cmd.set("splitbelow")
vim.cmd.set("shiftwidth=4")
vim.cmd.set("expandtab")
vim.cmd.set("tabstop=4")
vim.cmd.set("incsearch")
vim.cmd.nnoremap("<c-j> <c-w>j")
vim.cmd.nnoremap("<c-k> <c-w>k")
vim.cmd.nnoremap("<c-h> <c-w>h")
vim.cmd.nnoremap("<c-l> <c-w>l")
vim.cmd.let("g:vimtex_compiler_method = 'latexmk'")
vim.cmd.let("g:vimtex_view_method = 'zathura'")
vim.cmd.let("g:vimtex_quickfix_mode=0")
vim.cmd.set('conceallevel=1')
vim.cmd.let("g:tex_conceal='abdmg'")
vim.cmd.hi("Conceal ctermbg=none")
vim.cmd.colorscheme("gruvbox")

-- IF I WANTED VSCODE I WOULD HAVE USED IT
vim.cmd.set("mouse=")

vim.cmd.nmap("<C-F>     :Lf<CR>")
vim.cmd.nmap("<C-B>     :buffers<CR>")
vim.cmd.nmap("<F2>      :Neotree<CR>")
vim.cmd.nmap("<C-Q>     :q<CR>")
vim.cmd.nmap("<F3>      :split<CR>")
vim.cmd.nmap("<F5>      :split term://bash<CR>")
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- lsp configuration
vim.lsp.enable('pylsp')
vim.lsp.enable('bashlsp')
vim.lsp.enable('lua-ls')
vim.lsp.enable('clangd')
vim.lsp.enable('ltex-ls')
vim.lsp.enable('zig')
vim.lsp.enable('rust')
vim.lsp.enable('odin')
vim.lsp.enable('typ')
vim.lsp.enable('asm')

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
