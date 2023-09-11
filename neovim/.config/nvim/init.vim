" Show absolute line number
set number
" Show relative line number
set relativenumber
" Enable syntax
syntax on
" Auto indent
set autoindent
set cindent
" Incremental case-insensitive search 
set hlsearch
set ignorecase
set incsearch
" Color schmeme
colorscheme maui
" Default file encoding
set encoding=utf-8
" Tab length
set tabstop=4
" Indent length
set softtabstop=4
set shiftwidth=4
" Use tab at the start of a line or paragraph
set smarttab
set expandtab
" Disable backup file
set nobackup
" Disable undo file
set noundofile
" Enable line highlight
set cursorline
" Enable column highlight
set cursorcolumn
" Fold block by syntax
set foldmethod=syntax
" Disable block fold on startup
set nofoldenable
" Set lines left to the margin
set scrolloff=3
" Completion option
set completeopt=menu,preview,longest
" Enable plugin for specific file type
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" Show status line always
set cmdheight=2
set laststatus=2
" Auto-Completion for Vim command
set wildmenu
" Switch to the other buffer without saving current buffer
set hidden
" Jump to the window already displaying desired buffer instead of creating new
" one
set switchbuf=useopen
" remap leader
let mapleader = ","

" Navigate through buffers
nmap <C-l> :bnext<CR>
nmap <C-k> :bprevious<CR>

"Auto-install plugins and colorscheme
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  execute "!" . 'curl -fLo ' . stdpath('data') . '/site/colors/maui.vim --create-dirs https://raw.githubusercontent.com/darkgeek/vim-maui/master/colors/maui.vim'
  execute 'colorscheme maui'
  execute '!' . 'curl -fLo ' . stdpath('data'). '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif

" Check ctags availability: universal ctags has different names on different
" platforms, for example, it's called 'uctags' on OpenBSD, while 'ctags' on
" Debian and ArchLinux. And on NetBSD, universal ctags from pkgsrc is located below
" /usr/pkg/bin. 
if executable('uctags')
    let g:ctags_prog_name = 'uctags'
elseif executable('/usr/pkg/bin/ctags')
    let g:ctags_prog_name = '/usr/pkg/bin/ctags'
else 
    let g:ctags_prog_name = 'ctags'
endif

" Begin Plug
call plug#begin(stdpath('data') . '/plugged')

" Plugins 
Plug 'junegunn/vim-plug'
Plug 'jiangmiao/auto-pairs'
Plug 'maralla/completor.vim'
Plug 'darkgeek/sudow', { 'on': 'Sudow' }
Plug 'img-paste-devs/img-paste.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" End Plug
call plug#end()            

" [completor] Enable LSP
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls'}
let g:completor_filetype_map.c = {'ft': 'lsp', 'cmd': 'clangd'}
" [completor] keybindings
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>f :call completor#do('format')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

" [auto-pairs] Disable keybindings
" See https://github.com/jiangmiao/auto-pairs#shortcuts
let g:AutoPairsShortcutToggle = ''

" [img-paste] Enable keybindings for markdown
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
