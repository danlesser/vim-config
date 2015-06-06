set nocompatible
call plug#begin('~/.vim/plugged')

" ----------------------------------------------
" Define all the plugins!
" ----------------------------------------------

Plug 'AdamWhittingham/projector_mode'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bogado/file-line'
Plug 'colorizer'
Plug 'godlygeek/tabular'
Plug 'gregsexton/MatchTag'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'regedarek/ZoomWin'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'

" Search and file exploring
Plug 'ack.vim'
Plug 'bufexplorer.zip'
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-projectionist'

" Additional contextual information
Plug 'AdamWhittingham/vim-copy-filename'
Plug 'AutoTag'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'gregsexton/MatchTag'
Plug 'majutsushi/tagbar'

" Extra text manipulation and movement
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user'
Plug 'matchit.zip'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" Snippets and autocomplete
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-endwise'

" Extra syntax highlighting and language support
Plug 'scrooloose/syntastic'
  " Ruby
  Plug 't9md/vim-ruby-xmpfilter',        {'for': 'ruby'}
  Plug 'vim-ruby/vim-ruby',              {'for': 'ruby'}
  Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'}
  Plug 'ecomba/vim-ruby-refactoring',    {'for': 'ruby'}
  Plug 'vroom',                          {'for': 'ruby'}
  " Web stuff
  Plug 'cakebaker/scss-syntax.vim',      {'for': 'css'}
  Plug 'digitaltoad/vim-jade'
  Plug 'groenewege/vim-less'
  Plug 'othree/html5.vim',               {'for': 'html'}
  Plug 'pangloss/vim-javascript',        {'for': 'javascript'}
  Plug 'plasticboy/vim-markdown'
  Plug 'vim-coffee-script'
  " Misc Languages
  Plug 'elixir-lang/vim-elixir'
  Plug 'tpope/vim-haml'
  Plug 'chase/vim-ansible-yaml'

Plug 'kien/rainbow_parentheses.vim'

if filereadable(expand("~/.vim.plugins.local"))
  source ~/.vim.plugins.local
endif

" ----------------------------------------------
" No More plugins after here thanks!
" ----------------------------------------------

call plug#end()
filetype plugin indent on
syntax on

" ----------------------------------------------
" Setup basic Vim behaviour
" ----------------------------------------------

let mapleader = ","
" Space is a vary popular leader key, so make it mimic leader
nmap <space> <leader>
nmap <space><space> <leader><leader>

colorscheme adCode

set autoindent
set autowrite       " Writes on make/shell commands
set backspace=start,indent,eol
set backupdir=/var/tmp,~/.tmp,. " Don't clutter project dirs up with swap files
set directory=/var/tmp,~/.tmp,.
set cf              " Enable error files & error jumping.
set cursorline
set expandtab
set hidden          " Allow buffer switching without saving
set history=1000    " Remember a decent way back
set laststatus=2    " Always show status line.
set mousehide
set nofoldenable    " Disable all folding of content
set nowrap          " Line wrapping off
set number          " line numbers
set ruler           " Ruler on
set scrolloff=3     " More context around cursor
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set shiftwidth=2
set smarttab
set statusline=%<%f\ %h%m%r%=%-20.(line=%l\ of\ %L,col=%c%V%)\%h%m%r%=%-40(,%n%Y%)\%P%#warningmsg#%{SyntasticStatuslineFlag()}%*
set tabstop=2
set timeoutlen=500
set wildmode=list:longest " Shell-like behaviour for command autocompletion
set fillchars+=vert:\  "Set the window borders to not have | chars in them

" -----------------------------------
" Setup file wildcard ignored names
" -----------------------------------

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.jar

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Ignore node modules
set wildignore+=node_modules/*

" Disable temp and backup files
set wildignore+=*.swp,*.swo,*~,._*

call yankstack#setup()

" GVim Options
set guioptions-=T     " no toolbar
set guioptions-=m     " no menu
set guioptions+=LlRrb " Hack which adds all scrollbars so that they can be removed, line below breaks without this
set guioptions-=LlRrb " Remove all scrollbars

" Search options
set hlsearch        " highlight search matches...
set incsearch       " ...as you type
set ignorecase
set smartcase

" Show lines which have been break-indented with a special character
if v:version > 704 || v:version == 704 && has("patch338")
  set breakindent
  set showbreak=►►
endif

" ----------------------------------------------
" Command Shortcuts
" ----------------------------------------------

" make W and Q act like w and q
command! W :w
command! Q :q
command! Qa :qa

" Disable Ex Mode to remove confusion
nnoremap Q <Nop>

" make Y consistent with C and D
nnoremap Y y$

" <leader>. to view all document buffers
nmap <silent> <unique> <Leader>. :BufExplorer<CR>

" Double leader to switch to the previous buffer
map <silent> <Leader><Leader> :b#<CR>

" <leader>] to toggle the tags sidebar
nmap <Leader>] :TagbarToggle<CR>

" <leader>a<?> to align visually selected lines on <something>
vnoremap <silent> <Leader>a= :Tabularize /=<CR>
vnoremap <silent> <Leader>a=> :Tabularize /=>/l1c1r1<CR>
vnoremap <silent> <Leader>a, :Tabularize /,\@<=/l0r1<CR>
vnoremap <silent> <Leader>a{ :Tabularize /{<CR>
vnoremap <silent> <Leader>a\| :Tabularize /\|<CR>
vnoremap <silent> <Leader>a: :Tabularize /\w:\zs/l0l1<CR>
vnoremap <silent> <Leader>a<space> :Tabularize /[^ ] \+\zs/l0r1<CR>

"  <Leader>f to clear cache and fuzzy search files; ,F in current file's directory
map <silent> <leader>f :ClearCtrlPCache<cr>\|:CtrlP<cr>
map <silent> <leader>F :ClearCtrlPCache<cr>\|:CtrlPCurFile<cr>

"  <Leader>} to Search for a tag in the current project
map <silent> <leader>} :CtrlPTag<cr>

"  <Leader>g to jump to the next change since git commit
"  <Leader>G to jump to the last change since git commit
nmap <leader>g <Plug>GitGutterNextHunk
nmap <leader>G <Plug>GitGutterPrevHunk

"  <Leader>gt to toggle the gutter
nmap <leader>gt :GitGutterToggle<CR>

"  <Leader>gh highlight changed lines
nmap <leader>gh :GitGutterLineHighlightsToggle<CR>

"  <Leader>h to dismiss search result highlighting until next search or press of 'n'
:noremap <silent> <leader>h :noh<CR>

"  <Leader>H to show hidden characters
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>H :set nolist!<CR>

" Rainbow colour parens and brachets to see what matches and which levels
map <silent> <leader>) :RainbowParenthesesToggleAll<CR>

"  <Leader>m to toggle file tree (,M to select the current file in the tree)
nmap <silent> <Leader>m :NERDTreeToggle<CR>
map <silent> <Leader>M :NERDTreeFind<CR>

"  <Leader>rt to run ctags on the current directory
map <leader>rt :!ctags -R .<CR><CR>

"  <Leader>s and ,S to split and join lines
nmap <silent> <leader>s :SplitjoinSplit<cr>
nmap <silent> <leader>S :SplitjoinJoin<cr>

"  <Leader>sp to toggle spelling highlighting
nmap <silent> <Leader>sp :setlocal spell! spelllang=en_gb<CR>

"  <Leader>sw to strip whitespace off the ends
nmap <silent> <Leader>sw :call StripTrailingWhitespace()<CR>

"  <Leader>t to run tests
map <silent> <leader>t :VroomRunTestFile<CR>
map <silent> <leader>T :VroomRunNearestTest<CR>

"  <Leader>u to toggle undo history browser
nnoremap <Leader>u :GundoToggle<CR>

"  <Leader>z to zoom pane when using splits
map <Leader>z :ZoomWin<CR>

"  <Leader>= to switch to better style for projecting
noremap <silent> <leader>= :ToggleProjectorMode<CR>

"  <Leader>$ to toggle line wrap
map <silent> <leader>$ :set wrap!<CR>

" A-c to copy to the global buffer
vmap <A-c> "+y<CR>

" A-v to paste from the global buffer
map <A-v> "+p<CR>

" Ctrl+s to write the file (Will scroll-lock Vim in the terminal!)
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Replace the default U (undo last line) to Redo for speedyness
nmap U <c-r>

" Ctrl+\ to view the Vim style of the text under the cursor
nmap <C-\> :call <SID>SynStack()<CR>

" F5 to reload doc
map <silent> <F5> <esc>:e %<CR>

" Start interactive EasyAlign in visual mode (e.g. vipa)
vmap a <Plug>(LiveEasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(LiveEasyAlign)

" ----------------------------------------------
" Insert Mode Abbreviations
" ----------------------------------------------

" Try to auto-complete xml tags on typing '</'
iabbrev </ </<C-X><C-O>

" ----------------------------------------------
" Window split & size shortcuts
" ----------------------------------------------

" <leader> w for window commands
map <leader>w <c-w>w
map <leader>ws :vsplit<CR>
map <leader>wS :split<CR>

" C-w s to vertical split
map <C-w>s :vsplit<CR>

" C-w S to horizontal split
map <C-w>S :split<CR>

" C-A-h and C-A-l to resize vertical split
map <C-A-h> :vertical resize -7<CR>
map <C-A-l> :vertical resize +7<CR>

" C-A-j and C-A-k to resize horizontal split
map <C-A-j> :resize -5<CR>
map <C-A-k> :resize +5<CR>

" C-H and C-L to jump left and right between splits
map <C-h> <C-w>h
map <C-l> <C-w>l
"
" C-J and C-K to jump down and up between splits
map <C-j> <C-w>j
map <C-k> <C-w>k

let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" ----------------------------------------------
" Auto-complete shortcuts
" ----------------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \   'default' : '',
    \   'vimshell' : $HOME.'/.vimshell_hist',
    \   'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <Space>: close popup and add space
inoremap <silent> <Space> <C-r>=<SID>my_space_function()<CR>
function! s:my_space_function()
  return neocomplcache#smart_close_popup() . "\<Space>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif

let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" NeoSnippet Settings
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" ----------------------------------------------
" Map Uncommon Filetype for Syntax Highlighting
" ----------------------------------------------

au BufRead,BufNewFile *.scss set filetype=scss.css
au BufRead,BufNewFile *.jade.html set filetype=jade
au BufRead,BufNewFile *.palette set filetype=ruby

" ----------------------------------------------
" Setup Look & Feel
" ----------------------------------------------

" Setup the projector toggle plugin
let g:default_colorscheme = 'adCode'
let g:projector_colorscheme = 'mac-classic'

" Setup Font
if has('win32')
  set guifont=Consolas\ 10
elseif has('mac')
  set guifont=Menlo:h12
elseif has("unix")
  set guifont=DejaVu\ Sans\ Mono\ 10
  " if you don't have these fonts, set one in your ~/vim.local file like this:
  " else
  "   set guifont=fontname\ 10
endif

" Display soft column limit in modern versions of vim
if version >= 730
  au WinEnter,FileType * set cc=
  au WinEnter,FileType ruby,eruby,rspec,cucumber set cc=140
endif

" Ignore blank lines when calculating indentaiton on ansible yml configs
let g:ansible_options = {'ignore_blank_lines': 0}

" ----------------------------------------------
" Setup CtrlP File Finder
" ----------------------------------------------

let g:ctrlp_show_hidden = 1

" Use Ag for search if its available on this system
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ----------------------------------------------
" Setup Misc Vim Behaviours
" ----------------------------------------------

" Setup vim-airline to look nicer
let g:airline_left_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
let g:airline_section_z = '%c, %l/%L'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tagbar#enabled = 0

let g:airline_theme = "kolor"

autocmd FileType make set noexpandtab

" Extend % to do/end etc
runtime! plugin/matchit.vim

" Fix supertab/endwise incompatibility
let g:SuperTabCrMapping = 0
let g:SuperTabDefaultCompletionType = "<c-n>"

" Highlight trailing whitespace
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

" A whole bunch of NERDTree configuration stolen from carlhuda's janus
let NERDTreeIgnore=['\.rbc$', '\~$']

" Make NERDTree close when you open a file from it. Helps recover screen space!
let NERDTreeQuitOnOpen=1

" Disable netrw's autocmd, since we're ALWAYS using NERDTree
runtime plugin/netRwPlugin.vim
augroup FileExplorer
  au!
augroup END

let g:NERDTreeHijackNetrw = 0

" If the parameter is a directory (or there was no parameter), open NERDTree
function s:NERDTreeIfDirectory(directory)
  if isdirectory(a:directory) || a:directory == ""
    NERDTree
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  if isdirectory(a:directory)
    call ChangeDirectory(a:directory)
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(stay)
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      NERDTree
      if !a:stay
        wincmd p
      end
    endif
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . a:dir
  let stay = exists("a:1") ? a:1 : 1
  call s:UpdateNERDTree(stay)
endfunction

function Touch(file)
  execute "!touch " . a:file
  call s:UpdateNERDTree(1)
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . a:file
  endif
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . a:file

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . a:file)}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(system("dirname " . a:file), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")

" Jump to last cursor position when opening a file
" Don't do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal g`\""
    endif
  end
endfunction

" strip trailing whitespace<foo&bar>
"autocmd BufWritePre,FileWritePre * call StripTrailingWhitespace()
function! StripTrailingWhitespace()
	normal mz
	normal Hmy
	exec '%s/\s*$//g'
	normal 'yz<cr>
	normal `z
endfunction

" Delete comment character when joining commented lines
 if v:version > 703 || v:version == 703 && has("patch541")
   set formatoptions+=j
 endif

" Use only 1 space after "." when joining lines instead of 2
set nojoinspaces

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" Add function for showing the syntax tag for the selected text
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


"define :Lorem command to dump in a paragraph of lorem ipsum
command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum

"define :Hipster command to dump in a paragraph of Hipster ipsum
command! -nargs=0 Hipster :normal iTrust fund fashion axe bitters art party
      \ raw denim. XOXO distillery tofu, letterpress cred literally gluten-free
      \ flexitarian fap. VHS fashion axe gluten-free 90's church-key, kogi
      \ hashtag Marfa. Kogi Tumblr Brooklyn chambray. Flannel pickled YOLO
      \ semiotics. Mlkshk keffiyeh narwhal, mumblecore gentrify raw denim food
      \ truck DIY. Craft beer chia readymade ethnic, hella kogi Vice jean shorts
      \ cliche cray mlkshk ugh cornhole kitsch quinoa

" Automatically turn on colorizers highlighting for some filetypes
let g:colorizer_auto_filetype='css,haml,html,less,scss,vim'

" Make colorizer play nicely with 2html
let g:colorizer_syntax = 1

" Enable wrapping when editing text documents (eg Markdown)
autocmd BufNewFile,BufRead *.md :setlocal wrap

" Setup relative number toggle on Ctrl+n
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
  set number
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"  Set the git gutter colors to be the same as the number column
hi clear SignColumn

" Set the Gutter to show all the time, avoiding the column 'pop' when saving
let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~'
let g:gitgutter_max_signs = 1000

" Vroom settings
let g:vroom_write_all = 1
let g:vroom_cucumber_path = 'cucumber '
let g:vroom_map_keys = 0

" xmp-filter mappings
autocmd FileType ruby nmap <buffer> <Leader>X <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <Leader>X <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <Leader>X <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <Leader>x <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <Leader>x <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <Leader>x <Plug>(xmpfilter-run)

" Disable Markdown folding
let g:vim_markdown_folding_disabled=1

" Don't report Angular ng-* attributes as errors in HTML
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Projectionist defaults
let g:projectionist_heuristics ={
      \  "spec/*.rb": {
      \     "app/*.rb":       {"alternate": "spec/{}_spec.rb",         "type": "source"},
      \     "lib/*.rb":       {"alternate": "spec/{}_spec.rb",         "type": "source"},
      \     "spec/*_spec.rb": {"alternate": ["app/{}.rb","lib/{}.rb"], "type": "test"}
      \  }
      \}

" ----------------------------------------------
"  Source any local config
"  Keep this last to make sure local config overrides global!
" ----------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Enable ragtag XML tag mappings
let g:ragtag_global_maps = 1
