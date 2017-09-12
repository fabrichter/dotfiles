set nocompatible
filetype plugin on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

call plug#begin('~/.local/share/nvim/plugged')
" UI Stuff
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" File management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'zenbro/mirror.vim'

" Project management
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': ['Gitv'] }
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" IDE stuff
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar'
Plug 'neomake/neomake'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'rhysd/devdocs.vim'
Plug 'sbdchd/neoformat'
Plug 'metakirby5/codi.vim'
"Plug 'hkupty/iron.nvim'
"Plug 'bfredl/nvim-ipy'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'HiPhish/repl.nvim'
"Plug 'janko-m/vim-test'
Plug 'vimwiki/vimwiki'

" Language-specific
Plug 'artur-shaik/vim-javacomplete2'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Editing
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'tpope/vim-surround'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'peterrincker/vim-argumentative'
"Plug 'wellle/targets.vim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'michaeljsmith/vim-indent-object'
Plug 'bkad/camelcasemotion'
Plug 'AndrewRadev/linediff.vim'
call plug#end()

syntax enable
set background=dark
colorscheme NeoSolarized
set tabstop=4
set shiftwidth=4
set shiftround
" tabs or spaces should be handled by editorconfig
set number
set relativenumber
set hidden 
set incsearch
set inccommand=nosplit
set hlsearch
set cursorline
set wrapscan
set backup
set undofile
set autoread

let g:airline_powerline_fonts = 1
let mapleader = ','
" fzf goodness
noremap <leader>f :Files ~<CR>
noremap <leader>p :GFiles<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>l :Lines<space>
noremap <leader>x :Commands<CR>
noremap <leader>h :History<CR>
noremap <leader>T :Tags<CR>
noremap <leader>t :BTags<CR>
noremap <leader>/ :BLines<CR>
noremap <leader>? :Helptags<CR>
noremap <leader>s :Grepper<CR>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

noremap <leader>d :NERDTreeFind<CR>
noremap <leader>D :NERDTreeToggle<CR>
noremap <leader>g :Gstatus<CR>
noremap <leader>u :GundoToggle<CR>
noremap <leader>o :TagbarToggle<CR>
noremap ,w :update<CR>

noremap <leader>zo :OpenSession<CR>
noremap <leader>zO :OpenSession<space>
noremap <leader>zc :CloseSession<CR>
noremap <leader>zs :SaveSession<CR>
noremap <leader>zz :CloseSession<CR> :OpenSession<CR>

function! Focus()
	execute(':Goyo') 
	execute(':Limelight!!') 
endfunction
noremap <leader>F :call Focus()<CR>

nmap K <Plug>(devdocs-under-cursor)

" moving around, jump edition
map <space> <Plug>(easymotion-prefix)
nmap gl <Plug>(easymotion-overwin-line)
nmap gz <Plug>(easymotion-jumptoanywhere)
" moving around, search edition
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
noremap <leader>zc :CloseSession<CR>
" diable highlighting automatically
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-ea\symotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

call camelcasemotion#CreateMotionMappings(';')

nmap <leader>; <Plug>NERDCommenterToggle
vmap <leader>; <Plug>NERDCommenterToggle

let g:session_autoload = 'no'
let g:session_autosave = 'yes'

let g:neomake_enabled_makers = ['gradle', 'makeprg']

let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 20
set dictionary+=/usr/share/dict/words



let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:gitgutter_map_keys = 0
"autocmd BufWritePost * Neomake

autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java noremap <leader>C :Neomake! gradle<CR>
autocmd FileType pandoc noremap <leader>C :Pandoc! pdf<CR>
autocmd FileType pandoc noremap <leader>C :Pandoc! pdf<CR>

let g:codi#interpreters = {
	\ 'python': {
		\ 'bin': ["ipython", "--gui=qt5", "--classic", "--simple-prompt", "--no-color-info", "--no-banner", "-i"],
		\ 'prompt': '^\(>>>\|\.\.\.\)',
		\ },
	\ }
let g:codi#autoclose=0
let g:codi#autocmd='None'
let g:codi#newline=1
let g:codi#rightalign=0

let g:pandoc#folding#level = 3

let g:goyo_width=100

" Consistent movement (also in terminal mode)
tmap <A-h> <C-\><C-n><A-h>
tmap <A-j> <C-\><C-n><A-j>
tmap <A-k> <C-\><C-n><A-k>
tmap <A-l> <C-\><C-n><A-l>
tmap <A-b> <C-\><C-n><A-b>
tmap <A-n> <C-\><C-n><A-n>
tmap <A-p> <C-\><C-n><A-p>
tmap <A-t> <C-\><C-n><A-t>
tmap <A-T> <C-\><C-n><A-T>
tmap <A-;> <C-\><C-n><A-;>
tmap <A-,> <C-\><C-n><A-,>
tmap <A-.> <C-\><C-n><A-.>

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-b> :Buffers<CR>
nnoremap <A-n> :bnext<CR>
nnoremap <A-p> :bprev<CR>
nnoremap <A-t> :tabnext<CR>
nnoremap <A-T> :tabnew<CR>
nnoremap <A-;> <C-^>
nnoremap <A-,> 2<C-^>

nnoremap <A-.> 3<C-^>
