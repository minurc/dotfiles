" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let plug_readme=expand('~/.vim/autoload/plug.vim')
    if !filereadable(plug_readme)
        echo "Installing Plug.."
        echo ""
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let iCanHazVundle=0
    endif
set nocompatible
set showcmd

set path+=**
set wildmenu


filetype off
    set rtp+=~/.vim/plugged/
    call plug#begin()
    "Add your bundles here
    Plug 'altercation/vim-colors-solarized' "T-H-E colorscheme
    Plug 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'
    Plug 'https://github.com/fatih/vim-go.git'
"    Plug 'https://github.com/scrooloose/nerdtree.git'
    Plug 'https://github.com/elentok/plaintasks.vim.git'
    Plug 'https://github.com/PotatoesMaster/i3-vim-syntax.git'
    Plug 'https://github.com/vimoutliner/vimoutliner.git'        " Change vimoutlinerrc to desired state (inside plugin directory)
    Plug 'https://github.com/vim-scripts/xoria256.vim.git'       " Copy xoria256.vim to colors in ~/.vim



    "...All your other bundles...

    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :PlugInstall
    endif
" Setting up Vundle - the vim plugin bundler end
call plug#end()            " required

filetype plugin indent on    " required


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/



" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
" map <C-;> <NOP>
noremap <C-j> <c-w>j
noremap <C-k> <c-w>k
noremap <C-l> <c-w>l
noremap <C-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation



" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
let flColor=expand('~/.vim/colors/wombat256mod.vim')
if !filereadable(flColor)
    echo "Installing color scheme.."
    echo ""
    silent !curl -fLo ~/.vim/colors/wombat256mod.vim --create-dirs http://www.vim.org/scripts/download_script.php\?src_id=13400
endif

if !filereadable(flColor)
    set t_Co=256
    color wombat256mod
    " color xoria256
endif


" Enable syntax highlighting
" You need to reload this file for the change to apply
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder



" ===
" TODO implementation [ plugin ]
"
" git clone https://github.com/elentok/plaintasks.vim.git
"
" Usage:
"     + - create new task
"     = - toggle complete
"     <C-M> - toggle cancel
"     - - archive tasks
"       --<space> - insert a separator line


" ===
"
" AsciiDoc support
"
" Show tabs and trailing characters.
" "set listchars=tab:»·,trail:·,eol:¬
" set listchars=tab:»·,trail:·
" set list

" Reformat paragraphs and list.
nnoremap <Leader>r gq}

" Delete trailing white space and Dos-returns and to expand tabs to spaces.
nnoremap <Leader>t :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>

autocmd BufRead,BufNewFile *.ad,*.adoc,*.asciidoc
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>


au! BufRead,BufNewFile *.otl    setfiletype votl

autocmd BufNewFile,BufReadPost *.md set filetype=markdown


"
" Go Programming language
"
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_struct = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1


" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = '¶'

" Airline configuration
" let g:airline_powerline_fonts = 1
" let g:Powerline_symbols='unicode'

"if !exists('g:airline_symbols')
"      let g:airline_symbols = {}
"endif

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Settings for python-mode
" Note: I'm no longer using this. Leave this commented out
" and uncomment the part about jedi-vim instead
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
"" map <Leader>g :call RopeGotoDefinition()<CR>
"" let ropevim_enable_shortcuts = 1
"" let g:pymode_rope_goto_def_newwin = "vnew"
"" let g:pymode_rope_extended_complete = 1
"" let g:pymode_breakpoint = 0
"" let g:pymode_syntax = 1
"" let g:pymode_syntax_builtin_objs = 0
"" let g:pymode_syntax_builtin_funcs = 0
"" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<Leader>z"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
let g:pymode_rope = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"" set completeopt=longest,menuone
"" function! OmniPopup(action)
""     if pumvisible()
""         if a:action == 'j'
""             return "\<C-N>"
""         elseif a:action == 'k'
""             return "\<C-P>"
""         endif
""     endif
""     return a:action
"" endfunction

"" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
"" set nofoldenable
