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
vim.cmd.nmap("<F5>      :split term://zsh<CR>")
vim.cmd.tnoremap("<C-E> <C-\\><C-n>")
-- vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- lsp configuration
vim.lsp.enable('pyright')
vim.lsp.enable('bashlsp')
vim.lsp.enable('lua-ls')
vim.lsp.enable('clangd')
vim.lsp.enable('ltex-ls')
vim.lsp.enable('zig')
vim.lsp.enable('rust')
vim.lsp.enable('odin')
vim.lsp.enable('typ')
vim.lsp.enable('asm')
vim.lsp.enable('js')
vim.lsp.enable('nim')

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
require('nvim-treesitter').install { 'rust', 'javascript', 'zig', 'nim' }
-- Make vimwiki and render-markdown play nice
require('render-markdown').setup({ file_types = { 'markdown', 'vimwiki' }, })
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
