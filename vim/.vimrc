" Disable vi compatibility
set nocompatible
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
" Use tab at the start of a line or paragraph
set smarttab
set noexpandtab
" Disable mouse
set mouse-=a
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
" 256-color support
set t_Co=256
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
" Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

" Navigate through buffers
nmap <C-l> :bnext<CR>
nmap <C-k> :bprevious<CR>

"Read Manpage in vim
runtime! ftplugin/man.vim

"Auto-install plugins and colorscheme
if empty(glob('~/.vim/autoload/plug.vim'))
  !curl -fLo ~/.vim/colors/maui.vim --create-dirs https://raw.githubusercontent.com/darkgeek/vim-maui/master/colors/maui.vim
  execute 'colorscheme maui'
  !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Begin Plug
call plug#begin()

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
