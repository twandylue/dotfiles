syntax on
set number
set relativenumber
set mouse=a
set tabstop=4 softtabstop=4
set shiftwidth=4
set scrolloff=8
set sidescrolloff=8
set expandtab
set smartindent
set nowrap
set smartcase
set ignorecase
set incsearch
set hlsearch
" set colorcolumn=120
set showmode
set showmatch
set showcmd
set cursorline
set nobackup
set noswapfile
set clipboard=unnamed
set backspace=indent,eol,start
set ttyfast
set guicursor="i:block"
set splitbelow
set splitright
set ruler
set shortmess-=S
set listchars=eol:↵,tab:>·,trail:.,extends:>,precedes:<,space:.
set list
set linebreak
set timeoutlen=1000
set ttimeoutlen=50
set path=.,,,**
set wildmenu
set wildmode=longest:full,full
set wildignore+=*/.git/*,*/node_modules/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*/bin/*,*/obj/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj

" Window Resizing
nnoremap <M-Left> :vertical resize +1<CR>
nnoremap <M-Right> :vertical resize -1<CR>
nnoremap <M-Up> :resize +1<CR>
nnoremap <M-Down> :resize -1<CR>

" Move lines
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

" native package
packadd cfilter

" Vim built-in manpage viewer 
runtime ftplugin/man.vim

" for wsl2 in Window
" ref: https://github.com/vim/vim/issues/6365#issuecomment-1504996542
if has('unix')
    set t_u7= 
    if $TERM =~ 'xterm-256color'
      set noek
    endif
endif

" wsl2 in Window yank support
" ref: https://github.com/microsoft/WSL/issues/4440#issuecomment-638884035
if has('win64') || has('win32') || has('win16')
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

"=====Font====="
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI
  endif
endif

"=====Statusline====="
set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=[%n]
set statusline+=\ 
set statusline+=%f
set statusline+=%m
set statusline+=\ 
set statusline+=%y
set statusline+=[Git%{b:gitbranch}]
set statusline+=%=
set statusline+=%l
set statusline+=:
set statusline+=%v
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=%p%% 
set statusline+=\ 

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').")"
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"=====Key Mappings====="
let mapleader=" "
nnoremap <silent> <Esc> :nohlsearch<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>m `
nnoremap gj gT
nnoremap gk gt
nnoremap <leader>w <C-W>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap Q <nop>
nnoremap Y y$
nnoremap D d$

" Insert Movement
inoremap <C-f> <C-o>a
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>

" Don't move on *
" nnoremap * *<c-o>

" for terminal mode
nnoremap <c-\> :tab term ++close<cr>
tnoremap <c-\> <C-w>:q!<CR>
tnoremap <Esc> <C-\><C-n>

"=====Plugin====="
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tommcdo/vim-exchange'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'github/copilot.vim'
call plug#end()

"=====Theme====="
colorscheme gruvbox
set background=dark
highlight search cterm=none ctermfg=black ctermbg=darkred
highlight LineNr ctermfg=grey ctermbg=238

"=====Highlightedyank====="
let g:highlightedyank_highlight_duration = 250

" use rg instead of native grep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ '!.git'
  set grepformat=%f:%l:%c:%m
endif
