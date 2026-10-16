-- lsp configuration

vim.lsp.config('pyright', {
  cmd = {'pyright-langserver', '--stdio'},
  filetypes = {'python'},
})
vim.lsp.config('lua-ls', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})
vim.lsp.config('ltex-ls', {
    cmd = {'texlab'},
    filetypes = {'tex'},
})
vim.lsp.config('bashlsp', {
    cmd = {'bash-language-server'},
    filetypes = {'bash'},
})
vim.lsp.config('clangd', {
   cmd = {'clangd'},
   filetypes = { "c", "c.doxygen", "cpp", "cpp.doxygen", "objc", "objcpp", "cuda" },
})
vim.lsp.config('zig', {
    cmd = {'zls'},
    filetypes = {'zig'},
    version = {'0.15'},
})
vim.lsp.config('rust', {
   -- cmd = {'bacon-ls'},
   cmd = {'rust-analyzer'},
   filetypes = {'rust'},
})
vim.lsp.config('odin', {
   cmd = {'ols'},
   filetypes = {'odin'},
})
vim.lsp.config('typ', {
   cmd = {'tinymist'},
   filetypes = {'typst'},
})
vim.lsp.config('asm', {
   cmd = {'asm-lsp'},
   filetypes = {'asm'},
})
vim.lsp.config('js', {
   cmd = {'typescript-language-server', '--stdio'},
   filetypes = {'typescript', 'javascript'}, -- , 'html'
})
vim.lsp.config('html', {
   cmd = {'vscode-html-language-server', '--stdio'},
   filetypes = {'html'},
})
vim.lsp.config('nim', {
   cmd = {'nimlangserver', '--stdio'},
   filetypes = {'nim'},
})
vim.lsp.config('kotlin', {
   cmd = {'intellij-server', '--stdio'},
   filetypes = {'kotlin'},
})
vim.lsp.config('java', {
   cmd = {'jdtls'},
   filetypes = {'java'},
})

