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
set nobackup
set incsearch
set hlsearch
set colorcolumn=120
set showmode
set showmatch
set cursorline
set ignorecase
set nobackup
set noswapfile
set wildmenu
set clipboard=unnamed
set backspace=indent,eol,start
set ttyfast
set guicursor="i:block"
set ruler

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
set statusline+=%F
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
nnoremap <S-h> ^
nnoremap <S-l> g_
nnoremap gj gT
nnoremap gk gt
nnoremap <space>ww <C-W>w
nnoremap <space>wh <C-W>h
nnoremap <space>wj <C-W>j
nnoremap <space>wk <C-W>k
nnoremap <space>wl <C-W>l
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap Q <nop>
imap jj <Esc>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-o> <C-o>a

" for terminal mode
nnoremap <c-\> :tab term ++close<cr>
tnoremap <c-\> <C-w>:q!<CR>
tnoremap <Esc> <C-\><C-n>

"=====Plugin====="
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tommcdo/vim-exchange'
Plug 'machakann/vim-highlightedyank'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

"=====Theme====="
colorscheme gruvbox
set background=dark
highlight search cterm=none ctermfg=black ctermbg=darkred

"=====Highlightedyank====="
let g:highlightedyank_highlight_duration = 250
