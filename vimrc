""""""""""
"
" vimrc file
"
"
" [1] https://github.com/fatih/dotfiles/blob/master/vimrc
" [2] https://github.com/amix/vimrc
" [3] https://github.com/junegunn/dotfiles/blob/master/vimrc
"
"


" ----------------------------------------------------------------------------
"   Plugin manager
" ----------------------------------------------------------------------------

" vim-plug
let PlugInstalledIs=1
let plug_readme=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_readme)
    echo "Installing Plug.."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let PlugInstalledIs=0
endif

filetype off
set rtp+=~/.vim/plugged/
call plug#begin()
Plug 'https://github.com/tpope/vim-fugitive' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'https://github.com/fatih/vim-go.git', { 'do': ':GoInstallBinaries' }
" Plug 'https://github.com/fatih/vim-go.git' ", { 'do': ':GoInstallBinaries' }
Plug 'https://github.com/scrooloose/nerdtree.git'
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

Plug 'https://github.com/PotatoesMaster/i3-vim-syntax.git'
Plug 'https://github.com/vimoutliner/vimoutliner.git'        " Change vimoutlinerrc to desired state (inside plugin directory)
Plug 'https://github.com/elentok/plaintasks.vim.git'

Plug 'https://github.com/vim-scripts/xoria256.vim.git'       " Copy xoria256.vim to colors in ~/.vim
Plug 'altercation/vim-colors-solarized' "T-H-E colorscheme

Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim',

if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

Plug 'SirVer/ultisnips',


if PlugInstalledIs == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PlugInstall
endif
call plug#end()


" ----------------------------------------------------------------------------
"   Basic setup
" ----------------------------------------------------------------------------

set nocompatible
set showcmd

set path+=**
set wildmenu


filetype plugin indent on    " required


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/



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

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

" qq to record, Q to replay
nnoremap Q @q

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``

" noremap <C-n> :nohl<CR>
" vnoremap <C-n> :nohl<CR>
" inoremap <C-n> :nohl<CR>


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


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" put quickfix window always to the bottom
augroup quickfix
    autocmd!
    autocmd FileType qf wincmd J
    autocmd FileType qf setlocal wrap

augroup END

" " Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h



" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W


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
set relativenumber
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


set laststatus=2

" ----- NERD Tree ----- "
" <F10>
nnoremap <F10> :NERDTreeToggle<cr>
nnoremap <Leader>f  :NERDTreeFind<cr>

" ----- tagbar ----- "
" <F11>
if v:version >= 703
  inoremap <F11> <esc>:TagbarToggle<cr>
  nnoremap <F11> :TagbarToggle<cr>
  let g:tagbar_sort = 0
endif


" ----- vim-fzf ----- "

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

" inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


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


"
" AsciiDoc support
"

" Show tabs and trailing characters.
" "set listchars=tab:»·,trail:·,eol:¬
" set listchars=tab:»·,trail:·
" set list

" Reformat paragraphs and list.
autocmd FileType asciidoc nnoremap <Leader>r gq}

" Delete trailing white space and Dos-returns and to expand tabs to spaces.
autocmd FileType asciidoc nnoremap <Leader>t :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>


autocmd BufRead,BufNewFile *.ad,*.adoc,*.asciidoc
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

autocmd FileType asciidoc noremap <F5>  :! adocrender %<CR>


au! BufRead,BufNewFile *.otl    setfiletype votl

autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" ----- vim-fugitive ----- "

vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

" ----- vim-go ----- "

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': '-local do/',
  \ }
let g:go_sameid_search_enabled = 1

let g:go_test_prepend_name = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_def_mode = "guru"
let g:go_echo_command_info = 1
let g:go_gocode_autobuild = 0
let g:go_gocode_unimported_packages = 0

let g:go_autodetect_gopath = 1
let g:go_info_mode = "guru"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_format_strings = 0

let g:go_modifytags_transform = 'camelcase'
let g:go_fold_enable = []


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!


  autocmd FileType go nmap <C-g> :GoDecls<cr>
  autocmd FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
"  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END



" ----- vim-airline ----- "

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


" ----- UltiSnips ----- "
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

