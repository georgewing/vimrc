"""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=400   " keep 400 lines of command line history

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
" 显示光标位置
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m
" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" required!
Bundle 'gmarik/vundle'

Bundle 'L9'
Bundle 'scrooloose/syntastic'
Bundle 'FuzzyFinder'
Bundle 'mru.vim'
Bundle 'ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mattn/emmet-vim'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'EasyMotion'
Bundle 'FencView.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mihaifm/vimpanel'
Bundle 'scrooloose/nerdtree'
Bundle 'SirVer/ultisnips'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'The-NERD-Commenter'
Bundle 'TaskList.vim'
" Bundle 'UltiSnips'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""

" Platform
function! MySys()
	if has("win32") || has("win64")
	return "windows"
elseif has("mac")
	return "mac"
else
	return "linux"
endif
endfunction

" 编码
set fileencodings=utf-8
" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set nobackup

set undodir=~/.vim/undos
set undofile

set laststatus=2   " Always show the statusline
set ambiwidth=single

set expandtab
" 行间距
set linespace=4
" 显示行号
set number
" 用 <> 调整缩进的长度
set shiftwidth=4
" tab 符的长度
set tabstop=4
set softtabstop=4

" 行号栏的宽度
set numberwidth=4
" 禁止自动换行
set nowrap
set wildmenu
set wildmode=longest:full,full
" set wildignore+=*.orig,*.pyc
" 分割窗口时 保持相等的宽/高
set equalalways
" 匹配括号的规则，增加了针对HTML的<>
set matchpairs=(:),{:},[:],<:>
" 退格、空格、上下箭头 遇到 行首 行尾 时 自动移动下一行(包括insert模式)
set whichwrap=b,s,<,>,[,]
set foldmethod=marker
set diffopt+=iwhite,vertical " 忽略缩进的差异

""""""""""""""""""""""""""""""""""""""""
" interface
""""""""""""""""""""""""""""""""""""""""

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running") || has("gui_macvim")
	colorscheme obsidian2
	let g:colors_name="obsidian2"
else
	colorscheme molokai
	let g:colors_name="molokai"
endif

if MySys() == "mac"	
	set guifont=Monaco:h13
	set guifontwide=Source_Code_Pro_Medium:h13
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_enable_domhtmlcss=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")

	" 取消默认的快捷键
	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1
	" 设置背影透明度
	set transparency=9
	" 隐藏工具栏
	set guioptions-=T 

endif

" autocmd
autocmd! bufwritepost .vimrc source ~/.vimrc

" filetype
autocmd BufNewFile,BufRead jquery.*.js set ft=javascript syntax=jquery
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
autocmd BufNewFile,BufRead *.scss set ft=scss

" Language support
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置 <leader> 快捷键
let mapleader=","
let g:mapleader=","

map <silent> <leader>rc :tabe ~/.vimrc<cr>
map <leader>q :q<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NREDTree setting
let g:NERDTreeWinSize = 20
nmap <silent> <leader>nt :call OpenNERDTree()<cr>

function! OpenNERDTree()
	" let tmp = g:eighties_minimum_width
	let g:eighties_minimum_width = 20
	:NERDTree
	" let g:eighties_minimum_width = tmp
endfunction

" eighties
let g:eighties_enabled = 1
let g:eidthies_minimum_width = 80
let g:eighties_extra_width = 0
let g:eighties_compute = 1

" Syntastic
let g:syntastic_javascript_checkers = ['jshint']
let g:loaded_html_syntax_checked = 1
let g:syntastic_auto_loc_list=0

" tasklist
nmap <silent> <leader>tl <Plug>TaskList

" tagbar
let g:tagbar_width = 20
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
nnoremap <leader>tb :TagbarToggle<CR>

" session
let g:session_autoload = 'no'
nnoremap <leader>ss :SaveSession
nnoremap <leader>so :OpenSession
nnoremap <leader>sd :DeleteSession
nnoremap <leader>sc :CloseSession<cr>
nnoremap <leader>sv :ViewSession<cr>

" ctrl-p
let g:ctrlp_working_path_mode=2 " .git/ .hg/ .svn/ .bzr/ _darcs/ or your own marker_dir/ marker_file
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:Powerline_symbols = 'compatible'

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["ultisnips"]

" neocomplcache
" Use neocomplcache
let g:neocomplcache_enable_at_startup = 1
" Use smartcase
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_max_list = 20

" html5
let g:html5_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:aria_attributes_complete = 0
