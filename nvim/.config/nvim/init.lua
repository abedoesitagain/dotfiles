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
vim.cmd.nmap("<F2>      :Neotree toggle<CR>")
vim.cmd.nmap("<F3>      :CalendarVR<CR>")
vim.cmd.nmap("<C-Q>     :q<CR>")
vim.cmd.nmap("<F5>      :ToggleTerm<CR>")
vim.cmd.nmap("<F6>      :split term://opencode<CR>")
vim.cmd.tnoremap("<C-E> <C-\\><C-n>")
-- vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

require("toggleterm").setup({
    size = 10, direction = "horizontal",
})


-- make main areas transparent
vim.cmd [[highlight Normal guibg=NONE]]
vim.cmd [[highlight StatusLine guibg=NONE]]
vim.cmd [[highlight TabLine guibg=NONE]]
vim.cmd [[highlight TabLineFill guibg=NONE]]
vim.cmd [[highlight SignColumn guibg=NONE]]
vim.cmd [[highlight WinSeparator guibg=NONE]]
