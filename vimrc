set nocompatible

set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set guioptions-=T " no toolbar
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set laststatus=2  " Always show status line.
set number " line numbers
set scrolloff=3 " More context around cursor
set hlsearch  " highlight search matches...
set incsearch " ...as you type
set ignorecase 
set smartcase
set hidden " Allow buffer switching without saving
set history=1000
set wildmode=list:longest " Shell-like behaviour for command autocompletion
set visualbell
set mousehide

let mapleader = ","

filetype plugin indent on " Enable filetype-specific indenting and plugins

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=start,indent,eol
autocmd FileType make     set noexpandtab

runtime! plugin/matchit.vim " extends % to do/end etc

colorscheme railscasts

if $COLORTERM == 'gnome-terminal'
  set term=xterm-color
  set guifont=DejaVu\ Sans\ Mono\ 10
else
  set guifont=DejaVuSansMono:h10
endif

" ,s to show trailing whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <Leader>n :NERDTreeToggle<CR>
map <Leader>r :Rake<CR>

" Folding settings
set foldmethod=indent "fold based on indent
set foldnestmax=3     "deepest fold is 3 levels
set nofoldenable      "dont fold by default
"
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
