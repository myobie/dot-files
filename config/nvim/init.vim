" basics
set encoding=utf-8
set mouse=a
set ruler
set number
set title
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" sometimes when switching open buffers I lose syntax highlighting and set
" hidden somehow fixes that
set hidden

" whitespace
set nowrap
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set list listchars=tab:\ \ ,trail:·

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <cr> :nohlsearch<cr>

" statusbar
set laststatus=2
set showcmd

" tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,node_modules,target,_build,deps

" remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" directories for swp files
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

" I must have this shortcut for hash rockets
imap <C-l> <Space>=><Space>

" reload externally modified files
set autoread

" need python3 support
if !has("python3")
  echo "install python3 with brew"
endif

call plug#begin()

Plug 'sheerun/vim-polyglot' " lots of languages
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag' " HTML tags
Plug 'tpope/vim-fugitive' " git support
Plug 'tomtom/tcomment_vim' " gc
Plug 'isRuslan/vim-es6' " regular javascript plug is missing newest features
Plug 'slashmili/alchemist.vim' " elixir server for metadata
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

Plug 'mattn/gist-vim'
  let g:gist_open_browser_after_post = 1
  let g:gist_detect_filetype = 2
  let g:gist_post_private = 1
  if has('macunix')
    let g:gist_clip_command = 'pbcopy'
  endif

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  " use tab for completion
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nnoremap <silent> <leader>t :FZF<cr>
  augroup localfzf
    au FileType fzf :tnoremap <buffer> <c-j> <c-j>
    au FileType fzf :tnoremap <buffer> <c-k> <c-k>
  augroup END

Plug 'neomake/neomake'
  " Run Neomake when I save any buffer
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END
  let g:neomake_markdown_enabled_makers = [] " markdown is too strict
  let g:neomake_javascript_enabled_makers = ['standard']
  let g:neomake_json_enabled_makers = []

Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'

call plug#end()

" font and colors
set background=dark
color default
syntax enable
set ttyfast
set ttimeoutlen=10

" ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" go
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

" swfit
autocmd FileType swift setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

" js/on
autocmd BufNewFile,BufRead *.js set ft=javascript
autocmd BufNewFile,BufRead *.json set ft=json
