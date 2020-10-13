
" ----- Vim General Settings -------------------------------------

" Vim theming
" let g:molokai_original = 1
" colorscheme monokai
" colorscheme monochrome
" colorscheme print_bw
"
" set bg=light
" colorscheme minimal
colorscheme nofrils-light
"
" Set vim_airline_theme at airline_theme section let g:airline_theme = 'pencil'
" let g:pencil_terminal_italics = 1 " colorscheme pencil

" To print hardcopy with line numbers
set printoptions=number:y

" Enable filetype dection, filetype specific scripts(ftplugins) filetype indent scripts
set smartindent
set autoindent
set cinkeys=0{,0},:,0#,!,!^F

" Set backpsace works as other editors though not recommended.
" ref: https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
set backspace=indent,eol,start

" Set tab stop
" https://stackoverflow.com/questions/2054627/how-do-i-change-tab-size-in-vim
" NOTES: Reason to set tabstop to 2 spaces because angular-cli default tabstop
" set to 2. Maybe change in next angular-cli (version 2.0)?
" Ref: https://github.com/angular/angular-cli/issues/6272
" Ref: https://github.com/angular/angular-cli/issues/1252
set tabstop=2
set shiftwidth=2
set expandtab

set number

" Set path variable to current directory for search files in current project
" To search: ':find <full-file-name-including-extension'>
" http://vim.wikia.com/wiki/Project_browsing_using_find
set path=$PWD/**

" Markdown syntax for *.md (Vim default setting just for README.md)
augroup markdown

    " remove previous autocmds
     autocmd!

    " Custom highlighting for headers
    autocmd FileType markdown highlight Title cterm=bold ctermfg=darkblue

    " set every new or read *.md buffer to use the markdown filetype
    autocmd BufRead,BufNew *.md setf markdown

augroup END

" |--------------- Mapping -----------------------------------
    imap jj <ESC>
    let mapleader = ","
    " Shortcut to `GoToDefinition` using YouCompleteMe plugin
    " To do: type `,gd`
    nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
    nnoremap <Leader>gg :YcmCompleter GoTo<CR>

    "map to run python from Vim by press F9 for python2 and F10 for python3
    nnoremap <F9> :echo system('python2 "' . expand('%') . '"')<cr>
    nnoremap <F10> :echo system('python3 "' . expand('%') . '"')<cr>
" |----------------/mapping ----------------------------------

" |------------------------------------------------------------
" | Vundle and Plugins
" |------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'Shougo/vimproc.vim'
    Plugin 'leafgarland/typescript-vim'
    Plugin 'Quramy/vim-js-pretty-template'
    Plugin 'alvan/vim-closetag'
    Plugin 'itchyny/lightline.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'fatih/vim-go'
    Plugin 'pangloss/vim-javascript'
    Plugin 'tpope/vim-surround'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'Quramy/tsuquyomi'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'terryma/vim-multiple-cursors'

    " Plugins using for markdown - ref:
    " https://www.swamphogg.com/2015/vim-setup/
    Plugin 'junegunn/goyo.vim'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'reedes/vim-pencil'
    Plugin 'jalvesaq/Nvim-R'

    " vim-codefmt and its dependencies
    Plugin 'google/vim-maktaba'
    Plugin 'google/vim-codefmt'
    Plugin 'google/vim-glaive'
    Plugin 'jmcantrell/vim-virtualenv'
    Plugin 'rust-lang/rust.vim'
    Plugin 'racer-rust/vim-racer'
    Plugin 'ocaml/vim-ocaml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on                    " required
" --------------- End vundle plugins ---------------------

" ------- Dependent packages for vim-codefmt -------------------------
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
" -------------------------------------------------------------------

" ---------------- Vim-go plugin ------------------------
let g:go_disable_autoinstall = 0
let g:go_fmt_autosave = 0 " disable fmt when saving
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_null_module_warning = 0 " disable warning when not using go module

" ----------------End of vim-go ------------------------

" --------------- Typescript-vim plugin -----------------
" Compiler settings
" To run the compiler, enter `:make`, this will run `tsc`
" against the last saved version of currently edited file.
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
" To make the QuickFix window automatically appear if `:make` has any errors.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

let g:typescript_indent_disable = 1

autocmd FileType typescript syn clear foldBraces

" ----------------- End of Typescript-vim -----------------

" --------------------------- Go Tagbar -------------------------------------------------
" go tagbar - go get -u github.com/jstemmer/gotags |
" https://github.com/majutsushi/tagbar.git
let g:tagbar_type_to = {
  \'ctagstype' : 'go',
  \ 'kinds' : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin' : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

" file browser nerdtree
map <C-n> :NERDTreeToggle<CR>


" -------------- TT. Cutomized mapping ---------------------------
" Remap <ESC> - need to type quickly.
:imap jj <ESC>


"-------------- Airline -----------------------------------------
" In order to display Airline theme, we need Powerline fonts.
" Read instruction to install powerline fonts from Airline plugin repo.
set laststatus=2
" Make sure powerline fonts are used
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"let g:airline_symbols.space = "\ua0"
" let g:airline_theme="tomorrow"
" let g:airline_theme = 'pencil'
let g:airline_theme = 'papercolor'
let g:airline#extensions#tabline#enabled = 1 "enable the tabline
let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename of buffers in the tab line
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"-------------- find files and populate the quickfix list ---------
 fun! FindFiles(filename)
   let error_file = tempname()
   silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
   set errorformat=%f:%l:%m
   exe "cfile ". error_file
   copen
   call delete(error_file)
 endfun
 command! -nargs=1 FindFile call FindFiles(<q-args>)

" ------------------ vim-javascript -----------------------------
" Enable syntax highligting for JSDocs
let g:javascript_plugin_jsdoc = 1
" Enable syntax highlighting for NGDocs
let g:javascript_plugin_ngdoc = 1
" Enable syntax highligting for Flow
let g:javascript_plugin_flow = 1
" Enable code folding based on our syntax file
"set foldmethod=syntax

" ------------------- End of vim-javascript ---------------------

" ----------- Prettier - An opinionated Javascript Formatter ----
" To install: `sudo npm install -g prettier`
" Initiate plugin in vimrc
autocmd FileType javascript set formatprg=prettier\ --stdin
" format on save
autocmd BufWritePre *.js:normal gggqG

" ----------------- End of Prettier -----------------------------

" ----------------- Closetag ------------------------------------
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx"

" ----------------- End of Closetag -----------------------------

" ----------------- vim-js-pretty-template ---------------------
" syntax highlighting for angular template
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces

" --------------------------------------------------------------

" ---------------- NERD commenter -----------------------------
" Add spaces after comment delimiters by default
 let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'
let g:NERDDefaultAlign = 1

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
      " \ 'typescript': { 'left': '/**', 'right': '*/' }
" let g:NERDCustomDelimiters = {
      " \ 'c': { 'left': '/**','right': '*/'  }
      " \ }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" -----------------------------------------------------------------

" ---------------------- Vim-multiple-cursors ---------------------
"  `Ctrl + h` to highlight curren word or highlight part of word then
"  `Ctrl + h` to highlight next match. `Ctrl + p` to unselect and move
"  back to previous one.
"  `Ctrl + x` to remove current virtual cursor and skip to next one
" Remap `Ctrl + n` to `Ctrl + h` to avoid override `Ctrl + n` for NERDTree

" Step 1: Turn off the default mapping
let g:multi_cursor_use_default_mapping=0

" Step 2: Remap the default mapping
let g:multi_cursor_next_key='<C-h>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"  -----------------------------------------------------------------
"  ---------------------- Vim-markdown -----------------------------
"
"  Disable folding
let g:vim_markdown_folding_disabled = 1

" -------------------------------------------------------------------
"  --------------------- Vim YCM ------------------------------------
"  auto close the preview window
let g:ycm_autoclose_preview_window_after_completion = 1
" auto close preview window when escaping insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1
"  Fix using python3 instead of 2
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_rust_src_path = '/home/sugarme/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" Map subcommands
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gg :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <Leader>gt :YcmCompleter GoTo<CR>

" -------------------------------------------------------------------

" --------------- Custom Config for specific project ----------------
" Specific configuration for folders that contain `.vim`
" Ref: https://stackoverflow.com/questions/1889602/
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
else 
  " ----------------------- Vim-codefmt -------------------------------
  augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,typescript AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python3 AutoFormatBuffer yapf " use python 3 for yapf to format
    autocmd FileType rust AutoFormatBuffer rustfmt
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  augroup END
endif

" -------------------------------------------------------------------

" ----------------- Color Scheme to Print Back and White ------------
"  Ref: http://www.eandem.co.uk/mrw/vim/colorschemes/index.html#print_bw
" Make sure save file `print_bw` to `color` folder
" To print: 
" 1. Run `:colorscheme print_bw`; 
" 2. `:hardcopy > PATH_TO_OUTPUT/NAME.pdf`
" ------------------------------------------------------------------
"
