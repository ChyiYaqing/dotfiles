"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultimate Vim configuration all in one file (.vimrc)
"
" Maintainer:
"  	© 2025-chyidl (ChyiYaqing)
"
" Terminal font == Hack Nerd Font
" $ brew install --cask font-hack-nerd-font
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug Config
"
" :PlugInstall  to install plugins
" :PlugUpdate   to update plugins
" :PlugDiff     to review the changes from the last update
" :PlugClean    to remove plugins no longer in the list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" List your plugins here

Plug 'morhetz/gruvbox'      " Retro groove color scheme
Plug 'preservim/nerdtree'   " A tree explorer plugin for vim
Plug 'vim-airline/vim-airline'  " status/tabline for vim
Plug 'vim-airline/vim-airline-themes' " theme for airline
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go development plugin

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Config
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Sections:
" 	-> General
" 	-> VIM user interface
" 	-> Colors and Fonts
" 	-> Files and backups
" 	-> Text, Tab and indent related
" 	-> Visual mode related
" 	-> Moving around, tabs and buffers
" 	-> Status line
" 	-> Editor mappings
" 	-> Vimgrep searching and cope displaying
" 	-> Spell checking
" 	-> Misc
" 	-> Helper functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This option has the effect of makring Vim either more Vi-Compatible, or make Vim behave in a more useful way.
set nocompatible

" Open tagbar automatically in C files, optional
autocmd FileType c call tagbar#autoopen(0)
" Open tarbar automatically in Python files, optional
autocmd FileType python call tagbar#autoopen(0)

" Highlight trailing whitespaces as red.
highlight ExtraWhitespace ctermbg=red guibg=#EC7063
match ExtraWhitespace /\s\+$/

" Sets how may lines of history VIM has to remember
set history=2000

" Always show line number
set number


" Enable filetype plugins
filetype plugin on
filetype indent on
syntax on

" specify different areas of the screen where the splits should occur
set splitbelow
set splitright

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" press jk to exit from insert mode
imap jk <Esc>

" Editing :: Copy/Paste
" Tmux copy
set clipboard=unnamed

" :map 		-- listing key maps
" :nmap 	-- Display normal mode maps
" :imap 	-- Display insert mode maps
" :vmap 	-- Display visual and select mode maps
" :smap 	-- Display select mode maps
" :xmap 	-- Display visual mode maps
" :cmap 	-- Display command-line mode maps
" :omap 	-- Display operator pending mode maps

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" tl;dr Configure backspace so it acts as it should act
" indent: Vim adds automatic indentation for many filetypes
" eol: EOL markers (\n or = \r\n)
" start: This means you can only delete text that you've inserted since mode
" started, and you can't delete any text that was previously inserted
set backspace=eol,start,indent
" the left and right arrow keys, as well as h and l, to wrap when used at
" beginning or end of lines (< >) are the cursor keys used in normal and
" visual mode, and [ ] are the cursor keys in insert mode
set whichwrap+=<,>,h,l,[,]

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" By default, searching starts after you enter the string.
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of second ro blik
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
	autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" If you have vim >= 8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
	set termguicolors
endif

" make python code look pretty
let python_highlight_all=1


" To enable 256 colors in vim
set t_Co=256

" Colorscheme
try
    colorscheme gruvbox
catch
endtry

" gruxbox comes in two modes, dark and light
set background=dark  " Setting dark mode

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf-8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Vim recognizes three file formats (unix, dos, mac) that determine what line
" ending characters (line terminators) are removed from each line when a file
" is read.
" Use Unix as the standard file type
set ffs=unix,dos,mac

" highlight the current line and the cursor
set cursorline
set cursorcolumn

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" disgnostics appear/become resolved.
set signcolumn=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
" 'backup' 'writebackup' action
"   off       off 	 no backup made
"   off       on  	 backup current file, deleted afterwards (default)
"   on 	      off 	 delete old backup, backup current file
"   on 	      on 	 delete old backup, backup current file
set nobackup
set nowritebackup
" To disable swap files permanently
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs :)
set smarttab

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4
" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Linebreak on 500 characters
set linebreak
set textwidth=500
" Copy indent from current line when starting a new line.
set autoindent
" Do smart autoindenting when starting a new line
set smartindent
" This option changes how text is displayed
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful!
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" In normal mode
" gt        go to next tab
" gT        go to previous tab
" {i}gt     go to tab in position i

" let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map H ^
map 0 ^
map L $

" Move a line of text using Shift + ⬆️ or Shift + ⬇️
nnoremap <S-Down> :m+<CR>==࿿
nnoremap <S-Up> :m-2<CR>==
inoremap <S-Down> <Esc>:m+<CR>==gi
inoremap <S-Up> <Esc>:m-2<CR>==gi
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

" Delete trailing white space on save, useful for some filetypes :)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffe :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
" Move to next misspelled word after the cursor.
map <leader>sn ]s
" Like "]s" but search backwards
map <leader>sp [s
" Add word under the cursor as a good word to the first name in 'spellfile'
map <leader>sa zg
" For the word under/after the cursor suggest correctly spelled words
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Mappings to make Vim more friendly towards presenting slides.
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
    nnoremap <buffer> <Right> :n<CR>
    nnoremap <buffer> <Left> :N<CR>

    if !exists('#goyo')
        Goyo
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Emoji shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" using abbreviations
ab :bomb: 💣
ab :bulb: 💡
ab :book: 📖
ab :computer: 💻
ab :construction: 🚧
ab :email: 📧
ab :info: 🛈
ab :link: 🔗
ab :pencil: 📝
ab :pill: 💊
ab :point_right: 👉
ab :pushpin: 📌
ab :telephone: 📞
ab :warning: ⚠
ab :white_check_mark: ✅
ab :wrench: 🔧
ab :up_arrow: ⬆️
ab :down_arrow: ⬇️

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-W-v: open new VIM window next to the existing
" Ctrl-W-s: open new VIM window on the bottom of the currently selected window
" Ctrl-W-l: Move to the right window from the left by pressing
" Ctrl-W-h: Move to the left window

" The Ultimate Vim configuration successfully! Enjoy :-)

" Add the proper PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent

" full stack development
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2


" Turn off autoindent when you paste code, there's a special paste mode.
" :set paste
" turn off the paste-mode
" :set nopaste
" map <F3> can switch between paste and nopaste modes while editing the text
" set pastetoggle=<F3>

"hi Normal guibg=NONE ctermbg=NONE

" How to Edit Multiple Files Using Vim Editor
" :buffers  -- # to view the files which are being currently edited
" :buffer 1 -- # buffer followed by the buffer number. For example, to switch to the first file
" :bf       -- # Go to first file.
" :bl       -- # Go to last file.
" :bn       -- # Go to next file.
" :bp       -- # Go to previous file.
" :b number -- # Go to n'th file
" :bw       -- # close current file.

" Vim 折叠代码快捷键
" Normal Mode: z + a : 折叠整个文件的所有代码
" Normal Mode: z + r : 展开整个文件的素偶有折叠代码
" Normal Mode: z + c : 折叠当前光标所在的代码块
" Normal Mode: z + o : 展开当前光标所在的代码块
" Normal Mode: z + M : 折叠所有的代码块 -- Close all folds
" Normal Mode: z + R : 取消所有的代码折叠 -- Open all folds


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree Plugin Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open or Close NERDTree
map <leader>nn :NERDTreeToggle<cr>

" Quickly perform operations with NERDTreeFind
" 用于在文件树中定位当前打开的文件
map <leader>nf :NERDTreeFind<cr>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Show hidden files
let NERDTreeShowHidden=1
let NERDTreeShowFiles=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline Plugin Config
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enable = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go Plugin Config
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
