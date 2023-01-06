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

"=====Cursor====="
" let &t_ti.="\e[1 q"
" let &t_te.="\e[0 q"

" " insert mode
" let &t_SI.="\e[5 q"
" " normal mode
" let &t_EI.="\e[1 q"

"=====Mappings====="
let mapleader=" "
" NOTE: <Esc> 會造成問題(ref: https://vi.stackexchange.com/questions/2614/why-does-this-esc-normal-mode-mapping-affect-startup)
" nnoremap ,<space> :nohlsearch<cr>
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
inoremap <C-o> <C-o>a

" for terminal mode
nnoremap <c-\> :tab term ++close<cr>
tnoremap <c-\> <C-w>:q!<CR>
tnoremap <Esc> <C-\><C-n>

"=====Plugin====="
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'machakann/vim-highlightedyank'
"Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
call plug#end()

" ---theme---
colorscheme gruvbox
set background=dark
"highlight search cterm=none ctermfg=darkyellow ctermbg=darkred
highlight search cterm=none ctermfg=black ctermbg=darkred

" ---easymotion---
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"停用, 先使用內建的 highlight
"map n <Plug>(easymotion-next)
"map N <Plug>(easymotion-prev)

" ---sneak---
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S

" ---NERDTree---
" map <leader>e :NERDTree<CR>
" map <c-b> :NERDTreeClose<CR>
map <leader>e :NERDTreeToggle<CR>

"t: Open the selected file in a new tab
"i: Open the selected file in a horizontal split window
"s: Open the selected file in a vertical split window
"I: Toggle hidden files
"m: Show the NERD Tree menu
"R: Refresh the tree, useful if files change outside of Vim
"?: Toggle NERD Tree's quick help

"---vim-commentary---
" gcc: comment
" gc: comment in visual mode

"---highlightedyank---
let g:highlightedyank_highlight_duration = 250

"---lightline---
" set laststatus=2
" set noshowmode

"---ariline---
" set noshowmode
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='onedark'
" let g:airline_theme='dark'

"=======fugitive.vim=======
nnoremap <leader>gg :Git<CR>

" for vim-gitgutter
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
" Update sign column every quarter second
set updatetime=200
" Jump between hunks
" git next
nmap <Leader>g] <Plug>(GitGutterNextHunk)
" git previous
nmap <Leader>g[ <Plug>(GitGutterPrevHunk)
" git stage
nmap <Leader>gs <Plug>(GitGutterStageHunk)
" git undo
nmap <Leader>gr <Plug>(GitGutterUndoHunk)
" git preview
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
" close preview
nmap <Leader>gc :pclose<CR>
" 自動顯示/關閉 git preview
" au CursorMoved * if gitgutter#hunk#in_hunk(line(".")) | GitGutterPreviewHunk | else | pclose | endif

" =======indentline=======
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:vim_json_conceal=0

if &filetype == 'markdown'
    let g:indentLine_enabled = 0
endif
