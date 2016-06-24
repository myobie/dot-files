set nocompatible
filetype off

if !isdirectory(expand("~/.vim/bundle/Vundle.vim/.git"))
    !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-vividchalk'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fireplace'

Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'paredit.vim'
Plugin 'mattn/gist-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'matchit.zip'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'sickill/vim-pasta'
Plugin 'gregsexton/gitv'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'godlygeek/tabular'
Plugin 'mileszs/ack.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'derekwyatt/vim-scala'
Plugin 'fatih/vim-go'
Plugin 'zerowidth/vim-copy-as-rtf'
Plugin 'bogado/file-line'
Plugin 'scrooloose/syntastic'

Plugin 'myobie/dracula-theme', {'rtp': 'vim/'}
" Until https://github.com/zenorocha/dracula-theme/pull/70 is merged

call vundle#end()
filetype plugin indent on

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,node_modules,target,_build,deps

" Status bar
set laststatus=2

" Command-T configuration
let g:CommandTMaxHeight=20

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>Te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Tab Nav
map <Leader>Tn :tabn
map <Leader>Tp :tabp

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_javascript_checkers = ['standard']

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color default

" Default Font
set guifont=SF\ Mono\ Regular:h12
set antialias

" CommandT
map <leader>t :CommandT<CR>
imap <leader>t <Esc>:CommandT<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Mouse for scrolling
if has("mouse")
    set mouse=a
endif

" HTML5
syn keyword htmlTagName contained article aside audio canvas command datalist
syn keyword htmlTagName contained details embed figcaption figure footer header
syn keyword htmlTagName contained hgroup keygen mark meter nav output progress
syn keyword htmlTagName contained rp rt ruby section source summary time video

" go
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

" I must have this shortcut for hash rockets
imap <C-l> <Space>=><Space>

" Rspec.vim mappings
map <Leader>f :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!bin/rspec {spec}"

" clojure
nnoremap <C-e> :Eval<CR>
nnoremap E :%Eval<CR>
nnoremap ® :RainbowParenthesesToggle<CR>
autocmd BufRead,BufNewFile *.cljs setlocal filetype=clojure

" Ability to reload externally modified files
set autoread
