if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  " Command-Return for fullscreen
  " macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>


  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv
  imap <D-]> <ESC>vl>>gvi
  imap <D-[> <ESC>vl<<gvi
  map  <D-]> >>
  map  <D-[> <<

  " Command-Option-ArrowKey to switch windows
  map <D-M-Up> <C-w>k
  imap <D-M-Up> <Esc> <C-w>k
  map <D-M-Down> <C-w>j
  imap <D-M-Down> <Esc> <C-w>j
  map <D-M-Right> <C-w>l
  imap <D-M-Right> <Esc> <C-w>l
  map <D-M-Left> <C-w>h
  imap <D-M-Left> <C-w>h

  " Adjust viewports to the same size
  map <Leader>= <C-w>=
  imap <Leader>= <Esc> <C-w>=
endif

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T

" Default gui color scheme
color desert

set guifont=Menlo\ Regular:h15
set antialias
set encoding=utf-8
set lines=46 columns=140
set guioptions+=LlRrb
set guioptions-=LlRrb
