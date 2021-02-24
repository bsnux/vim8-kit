"---------------------------------------------------
" Vim 8.x configuration
"---------------------------------------------------

" Replacing a la multiple-cursor:
"    /test
"    cgn
"    .
" Vertical terminal:
"   :vertical term

"--- Automated installation of vimplug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

"--- Plugins
call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
" Syntax files
Plug 'chr4/nginx.vim'
Plug 'jvirtanen/vim-hcl'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'pearofducks/ansible-vim'
" git
Plug 'airblade/vim-gitgutter'
" Asynchronous Lint Engine
Plug 'dense-analysis/ale'
call plug#end()

"--- Color theme
"colo base16-ocean
colo base16-eighties
"colo base16-gruvbox-light-hard
"colo base16-tomorrow-night-eighties
"colo base16-google-light
"colo base16-helios
""colo base16-gruvbox-light-medium
"colo base16-materia

"--- Settings, functions and shortcuts
set termguicolors

filetype on
filetype plugin on
filetype plugin indent on

set nu
set encoding=utf-8
set noswapfile
set hidden
set clipboard=unnamed
set ignorecase
set colorcolumn=80
set splitright
set splitbelow
set expandtab
set tabstop=2
set shiftwidth=2
set hlsearch
set mouse=a
set backspace=2
let mapleader = ","

" Remove trailing whitespaces on save for some types of files
autocmd BufWritePre Dockerfile* %s/\s\+$//e
autocmd BufWritePre Jenkinsfile* %s/\s\+$//e
autocmd BufWritePre *.py %s/\s\+$//e
autocmd BufWritePre *.groovy %s/\s\+$//e

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
au BufNewFile,BufRead *.groovy set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
au BufNewFile,BufRead Jenkinsfile* set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent

" Automatically pairs
inoremap ' ''<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" italic for comments
highlight Comment cterm=italic gui=italic

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Use <C-l> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR><Paste>

" Emacs keys for command line
cnoremap <C-A>	<Home>
cnoremap <C-B>	<Left>
cnoremap <C-D>	<Del>
cnoremap <C-E>	<End>
cnoremap <C-F>	<Right>

" fuzzy search => use `:find <file>`
set path+=**
set wildmenu
nnoremap <c-p> :find 

" Emacs keybiding for insert mode
imap <C-e> <esc>$a
imap <C-a> <esc>0i
imap <C-f> <esc>lli
imap <C-b> <esc>i
imap <C-k> <esc>d$i

"--- Plugins conf
let g:airline_powerline_fonts = 2
let g:airline_theme='base16_google'
let g:airline#extensions#tabline#enabled = 1

let g:ale_sign_warning = '⚠️'
let g:ale_sign_error = '❌'
