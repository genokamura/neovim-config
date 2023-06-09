" General settings
set number
set relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set wrap
set linebreak
set showmatch
set ignorecase
set smartcase
set incsearch
set hidden
set laststatus=2
set smartindent
set clipboard+=unnamedplus
inoremap <silent> jk <ESC>
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Set up plugin manager
" We will use vim-plug here, but you can use other plugin managers as well
call plug#begin('~/.config/nvim/plugged')

" Plugins
Plug 'neovim/nvim-lspconfig'           " Language Server Protocol
Plug 'hrsh7th/nvim-compe'              " Autocomplete
Plug 'nvim-telescope/telescope.nvim'   " Fuzzy finder
Plug 'preservim/nerdtree'              " File explorer
Plug 'ryanoasis/vim-devicons'          " File icons
Plug 'airblade/vim-gitgutter'          " Git integration
Plug 'tpope/vim-fugitive'              " Git commands
Plug 'itchyny/lightline.vim'           " Statusline
Plug 'sheerun/vim-polyglot'            " Syntax highlighting
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" Language Server Protocol (LSP) settings
lua << EOF
require('lspconfig').tsserver.setup{}
require('lspconfig').bashls.setup{}
require('lspconfig').vimls.setup{}
require('lspconfig').jsonls.setup{}
require('lspconfig').html.setup{}
require('lspconfig').cssls.setup{}
require('lspconfig').dockerls.setup{}
require('lspconfig').yamlls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').intelephense.setup{}
EOF

" LSP setting
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

" Autocomplete settings
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.complete_length = 1
let g:compe.allow_prefix_unmatch = v:false

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

" Fuzzy finder settings
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <C-b> :Telescope buffers<CR>

" NERDTree settings
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['__pycache__', '.git', 'node_modules', '.cache']

" Lightline settings
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

" Use Nvim Devicons for NERDTree and Lightline
" let g:lightline.tabline_formatter = 1
" let g:lightline.formatter.tabline = 'MyFormatter'
" function! MyFormatter(tab) abort
"   let l:tab = get(a:tab, 'tab', '')
"   let l:dev = get(a:tab, 'dev', '')
"   return l:tab !=# '' && l:dev !=# '' ? l:tab.' '.l:dev : l:tab
" endfunction

" NERDTree settings
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'✹',
      \ 'Staged'    :'✚',
      \ 'Untracked' :'✭',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'═',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'☒',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }

autocmd VimEnter * NERDTree
let NERDTreeShowHidden = 1


let g:clipboard = {
  \   'name': 'WslClipboard',
  \   'copy': {
  \      '+': 'clip.exe',
  \      '*': 'clip.exe',
  \    },
  \   'paste': {
  \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  \   },
  \   'cache_enabled': 0,
  \ }
