set nocompatible
filetype off

" ================= PLUGINS ================= "
if empty(glob('~/.vim/autoload/plug.vim'))
    let g:first_time = 1
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | qall
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvie/vim-flake8'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'

call plug#end()

if exists('g:first_time')
    finish
endif

" ================ SETTINGS ================= "
filetype indent plugin on
filetype plugin on
syntax on
set autoindent
set smartindent
set hidden
set wildmenu
set showcmd
set nohlsearch
set wrap
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set number
set ttimeoutlen=50
set shiftwidth=4
set softtabstop=4
set expandtab
set autoread
set shortmess+=c
set whichwrap+=h,l,[,]
set fileformat=unix
set encoding=utf-8
set breakindent
set showmode
let python_highlist_all=1
let mapleader=","

set splitbelow
set splitright

map <C-n> :NERDTreeToggle<CR>

" ================= AUTOCMD ================= "

" Save all files on loss of focus
au FocusLost * :silent! wall
" Return to normal mode on loss of focus
au FocusLost * call feedkeys('\<C-\>\<C-n>')
" Disable paste when leaving insert mode
au InsertLeave * set nopaste
" Show git diff when writing a commit
au FileType gitcommit DiffGitCached | wincmd p
" Jump to the last position when reopening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" =============== HIGHLIGHTS ================ "
highlight Visual term=reverse ctermbg=237 guibg=#575b61
"highlight! link Search CursorLine
" ================ KEYBINDS ================= "
" Allows smooth movement through a line spanning multiple visual lines.
" This is good for editing LaTeX, as some of the lines can be quite long.
" Up & Down
nnoremap <S-j>      gj
nnoremap <S-k>      gk
vnoremap <S-j>      gj
vnoremap <S-k>      gk
" Right & Left
nnoremap <S-l>      $
nnoremap <S-h>      ^
vnoremap <S-l>      $
vnoremap <S-h>      ^
" Because of the above lines, it is no longer possible to join two lines. This
" bind fixes that.
nnoremap <leader>j  J

imap jk             <Esc>
imap kj             <Esc>

" Easy motion between splits. Also allows for some clever tmux usage where the
" same binds can be used to move effortlessly between tmux splits and Vim splits.
map <C-j>           <C-W>j
map <C-k>           <C-W>k
map <C-h>           <C-W>h
map <C-l>           <C-W>l
" Easily toggle spell checker.
map <leader>ss      :setlocal spell!<cr>

" Sort selection
vnoremap <leader>s  :sort<cr>
" Allows for easy indentation of selected lines in visual mode.
vnoremap <          <gv
vnoremap >          >gv
" Force write using sudo.
cmap w!!            %!sudo tee > /dev/null %
" Center view when iterating through matches in a search.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
" Replace standard jump motions with easymotion (sooo good).
map b               <Plug>(easymotion-b)
map B               <Plug>(easymotion-B)
map e               <Plug>(easymotion-e)
map E               <Plug>(easymotion-E)
map w               <Plug>(easymotion-w)
map W               <Plug>(easymotion-W)
map f       <Plug>(easymotion-overwin-f2)
map  /      <Plug>(easymotion-sn)
