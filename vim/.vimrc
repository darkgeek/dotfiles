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
" Specify tags file
set tags+=./tags
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
" Show status line always
set cmdheight=2
set laststatus=2
" Auto-Completion for Vim command
set wildmenu
" Default Omni Function
set omnifunc=syntaxcomplete#Complete
" Do not search included files to speed up Ctrl-P
set complete-=i
" Switch to the other buffer without saving current buffer
set hidden
" Jump to the window already displaying desired buffer instead of creating new
" one
set switchbuf=useopen

" Save read-only file after editing
command Sudow w !sudo tee % >/dev/null

" Navigate through buffers
nmap <C-l> :bnext<CR>
nmap <C-k> :bprevious<CR>

" Refresh ctags files upon saving
autocmd BufWritePost *
      \ if filereadable('tags') |
      \   call system('exctags -R --languages-force='.&ft) |
      \   echo "Tag refreshed." |
      \ endif

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
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" End Plug
call plug#end()            

" [tagbar] Show tag list on left
let tagbar_left=1 
" [tagbar] List tags shortcut
nnoremap <Leader>tl :TagbarToggle<CR> 
" [tagbar] Tagbar window size
let tagbar_width=32 
" [tagbar] Don't show extra help information
let g:tagbar_compact=1

