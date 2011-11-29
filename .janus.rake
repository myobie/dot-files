def remove_plugin_task(name)
  task(name).clear
  task("#{name}:pull").clear
  task("#{name}:install").clear
  file(File.expand_path("tmp/#{name}") => "tmp").clear
end

def override_plugin_task(name, repo=nil, &block)
  remove_plugin_task name
  vim_plugin_task name, repo, &block
end

def extend_plugin_task(name, &block)
  task "#{name}:install" do
    yield block
  end
end

override_plugin_task "nerdtree", "https://github.com/scrooloose/nerdtree.git"

remove_plugin_task "jslint"
vim_plugin_task "jshint", "https://github.com/wookiehangover/jshint.vim.git"

vim_plugin_task "vim-ruby", "https://github.com/vim-ruby/vim-ruby.git"
vim_plugin_task "ragtag", "https://github.com/tpope/vim-ragtag.git"
vim_plugin_task "repeat", "https://github.com/tpope/vim-repeat.git"
vim_plugin_task "scss", "https://github.com/cakebaker/scss-syntax.vim.git"
vim_plugin_task "sinatra", "https://github.com/hallison/vim-ruby-sinatra.git"
vim_plugin_task "camelcasemotion", "https://github.com/vim-scripts/camelcasemotion.git"
vim_plugin_task "css-color", "https://github.com/ap/vim-css-color.git" do
  sh "cp after/syntax/{css,less}.vim"
  sh "cp after/syntax/{css,scss}.vim"
end
vim_plugin_task "jasmine", "https://github.com/claco/jasmine.vim.git"
vim_plugin_task "html5-syntax", "https://github.com/othree/html5-syntax.vim.git"
vim_plugin_task "copy-as-rtf", "https://github.com/aniero/vim-copy-as-rtf.git"

vim_plugin_task "nerdtree_command-t" do
  File.open("after/plugin/nerdtree_command-t.vim", "w") do |f|
    f.puts <<-HACK
" NERDTree and Command-T compatibility hack
"
" Open an empty buffer and then start a real NERDTree, but only if
" vim was opened with a single directory as the first argument.
" The empty buffer gives command-t a buffer in which to open a
" file, rather than having it fail to clobber the default directory browser.
"
" This preserves the NERDTree netrw browsing replacement, but overrides it
" when vim is first loading.
"
" This script is in after/plugins since it needs to add the autocmd
" override after the plugin's autocmds are loaded and defined.

function ReplaceNERDTreeIfDirectory()
  if argc() == 0 || (argc() == 1 && isdirectory(argv(0)))
    " replace the directory browser with an empty buffer
    enew
    " and open a regular NERDTree instead
    NERDTree
  endif
endfunction

augroup NERDTreeHijackNetrw
  au VimEnter * call ReplaceNERDTreeIfDirectory()
augroup END
    HACK
  end
end
