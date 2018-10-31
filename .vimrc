call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-fugitive'

Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --go-completer --js-completer --rust-completer --java-completer' }

Plug 'nathanaelkane/vim-indent-guides'

Plug 'Raimondi/delimitMate'

Plug 'airblade/vim-gitgutter'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'SirVer/ultisnips'

Plug 'edkolev/tmuxline.vim'

Plug 'edkolev/promptline.vim'

Plug 'w0rp/ale'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-endwise'

Plug 'mileszs/ack.vim'

Plug 'qpkorr/vim-bufkill'

Plug 'majutsushi/tagbar'

Plug 'ludovicchabant/vim-gutentags'

Plug 'tpope/vim-abolish'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-obsession'

Plug 'tpope/vim-eunuch'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

set nocompatible
filetype plugin indent on

set t_Co=256
syntax on
colorscheme base16-oceanicnext
let base16colorspace=256
set background=dark

let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
set rtp+=/usr/local/opt/fzf

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ackprg = 'rg --vimgrep --no-heading'
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

set laststatus=2
set timeoutlen=50
set noshowmode
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#obsession#enabled = 1
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:UltiSnipsExpandTrigger="<c-j>"

let g:javascript_plugin_flow = 1

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ycm_autoclose_preview_window_after_completion = 1

let g:ale_linters = { 'java': [] }

let $JAVA_TOOL_OPTIONS='-javaagent:"' . expand('~') . '/dotfiles/lombok.jar" -Xbootclasspath/p:' . expand('~') . '/dotfiles/lombok.jar'

set encoding=utf-8
set number
set nohlsearch
set incsearch
set ignorecase
set ruler
set showmatch
set visualbell

set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set smarttab
set nowrap

autocmd FileType python setlocal expandtab shiftwidth=2 softtabstop=2

inoremap jk <ESC>
vnoremap jk <ESC>

imap <C-c> <CR><Esc>O

nmap ; :Buffers<CR>
nmap <C-P> :Files<CR>

execute "set <M-CR>=\<ESC>\<CR>"
nmap <M-CR> :YcmCompleter FixIt<CR>
nmap <C-B> :YcmCompleter GoTo<CR>

function! OpenFileInGithub()
  let filepath = expand('%')
  let origin = substitute(system('git config --get remote.origin.url'), '\n\+', '', '')
  let line_number = line('.')
  let repo_url = 'https://' . substitute(substitute(origin, '^git@\(.*\)\.git$', '\1', ''), ':', '/', '') . '/blob/master/' . filepath . '#L' . line_number
  call system('open ' . repo_url)
endfunction

nnoremap <Leader>og :call OpenFileInGithub()<CR>

" Create backupdir for storing tmp files
if !exists("*InitBackupDir")
  function InitBackupDir()
    if has('win32') || has('win32unix') "windows/cygwin
      let separator = "_"
    else
      let separator = "."
    endif
    let parent = $HOME .'/' . separator . 'vim/'
    let backup = parent . 'backup/'
    let tmp = parent . 'tmp/'
    if exists("*mkdir")
      if !isdirectory(parent)
        call mkdir(parent)
      endif
      if !isdirectory(backup)
        call mkdir(backup)
      endif
      if !isdirectory(tmp)
        call mkdir(tmp)
      endif
    endif
    let missing_dir = 0
    if isdirectory(tmp)
      execute 'set backupdir=' . escape(backup, " ") . "/,."
    else
      let missing_dir = 1
    endif
    if isdirectory(backup)
      execute 'set directory=' . escape(tmp, " ") . "/,."
    else
      let missing_dir = 1
    endif
    if missing_dir
      echo "Warning: Unable to create backup directories: " . backup ." and " . tmp
      echo "Try: mkdir -p " . backup
      echo "and: mkdir -p " . tmp
      set backupdir=.
      set directory=.
    endif
  endfunction
  call InitBackupDir()
endif
