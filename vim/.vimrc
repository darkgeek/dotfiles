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
" Tab length
set tabstop=4
" Indent length
set softtabstop=4
set shiftwidth=4
" Use tab at the start of a line or paragraph
set smarttab
set expandtab
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
call plug#begin('~/.vim/plugged')

" Plugins 
Plug 'junegunn/vim-plug'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'maralla/completor.vim'

" End Plug
call plug#end()            

" [gutentags] tell ctags do not search upwards when encounter one of these dirs
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" [gutentags] tag file name
let g:gutentags_ctags_tagfile = '.tags'
" [gutentags] put generated tags under ~/.cache
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" [gutentags] ctags params
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" [gutentags] universal ctags is named differently on OpenBSD
if system("uname -s") =~ "OpenBSD"
    let g:gutentags_ctags_executable = "uctags"
endif

" [gutentags] create ~/.cache/tags if missing
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" [leadf] config
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<Leader>n'
noremap <c-n> :LeaderfMru<cr>
noremap <Leader>p :LeaderfFunction!<cr>
noremap <Leader>n :LeaderfBuffer<cr>
noremap <Leader>m :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ShowDevIcons = 0
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" [completor] Enable LSP
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls'}
let g:completor_filetype_map.c = {'ft': 'lsp', 'cmd': 'clangd'}
