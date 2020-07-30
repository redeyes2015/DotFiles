" :PlugInstall to install plugins.
call plug#begin()

Plug 'tpope/vim-sensible'
" Press . on a file to pre-populate it at the end of a : command line.
" also !, which starts the line off with a bang.
" Press y. to yank an absolute path for the file under the cursor.
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/vcscommand.vim'
Plug 'briancollins/vim-jst', {'for': 'jst'}
Plug 'bling/vim-airline'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'dietsche/vim-lastplace'
Plug 'pi314/ime.vim', {'on': 'Liu'} " ctrl-space to turn on
Plug 'Tuxdude/mark.vim'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

Plug 'flazz/vim-colorschemes'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ General settings over vim-sensible]                                      {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set nocompatible
set hlsearch
set ignorecase
set smartcase

set undofile
set undodir=~/.vim/undofiles
set directory^=~/.vim/swap//

set splitright
set splitbelow
set switchbuf=usetab
set gdefault

set omnifunc=syntaxcomplete#Complete

colorscheme molokai
" ctermbg=235 from molokai is just too subtle
hi Visual                      ctermbg=238

" original setting from molokai always confues me about
" 'why my cursor suddonly jumpped, and where is it after all!?'
hi MatchParen cterm=bold,italic ctermfg=208 ctermbg=233

" Highlight ugly code
match ErrorMsg '\%>120v.\+'
match ErrorMsg '\s\+$'

" To avoid issues with gulp.watch
" see: https://github.com/nodejs/node-v0.x-archive/issues/3172
autocmd BufWritePre */project*   setlocal backupcopy=yes

autocmd FileType gitcommit setlocal spell
autocmd FileType netrw nnoremap <buffer> / :keeppattern /
autocmd FileType javascript,vue setlocal signcolumn=yes
autocmd FileType vue syntax sync fromstart
autocmd FileType vuejs set filetype=vue

let mapleader = ","

" Open the directory of current file in a vertical split / a new tab
nnoremap <Leader>- :Vexplore!<CR>
nnoremap <Leader>t- :Texplore<CR>

nnoremap `/ //e<CR>

function! Del_word_delims()
   let reg = getreg('/')
   " After *                i^r/ will give me pattern instead of \<pattern\>
   let res = substitute(reg, '^\\<\(.*\)\\>$', '\1', '' )
   if res != reg
      return res
   endif
   " After * on a selection i^r/ will give me pattern instead of \Vpattern
   let res = substitute(reg, '^\\V'          , ''  , '' )
   let res = substitute(res, '\\\\'          , '\\', 'g')
   let res = substitute(res, '\\n'           , '\n', 'g')
   return res
endfunction

inoremap <C-R>/ <C-R>=Del_word_delims()<CR>
cnoremap <C-R>/ <C-R>=Del_word_delims()<CR>

" I need %:p:h so much ... hit CTRL-] to expand immediately
cabbrev %/ %:p:h/

" I mis-type q: quite often...
nnoremap q: <nop>
nnoremap <leader>q: q:

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Plugin configuration ]                                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""
    " ale
    """"""""""""""""""""""""""""""
    let g:ale_sign_error = '✗✗'
    let g:ale_javascript_eslint_suppress_eslintignore = 1
    let g:ale_maximum_file_size = 40960

    """"""""""""""""""""""""""""""
    " ctrlp
    """"""""""""""""""""""""""""""
    let g:ctrlp_working_path_mode = 'rc'
    let g:ctrlp_root_markers = ['Makefile', 'package.json']
    let g:ctrlp_custom_ignore = {
      \ 'dir': 'node_modules',
      \ }

    """"""""""""""""""""""""""""""
    " FZF customization
    """"""""""""""""""""""""""""""
    command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

    nnoremap <C-P> :GFiles<CR>

    """"""""""""""""""""""""""""""
    " vim-vue
    """"""""""""""""""""""""""""""
    let g:vue_pre_processors = ['less']

    """"""""""""""""""""""""""""""
    " ultisnip
    """"""""""""""""""""""""""""""
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    """"""""""""""""""""""""""""""
    " ime.vue
    """"""""""""""""""""""""""""""
    " Terminal seems to translate <CTRL-Space> to <NUL> and trigger <CTRL-@> in
    " vim, which \"Insert previously inserted text and stop insert.\"
    " But that gets in the way of my old habit of togggling IME mode in windows
    " so let's use it as the toggle
    let g:ime_toggle_english='<C-@>'


    """"""""""""""""""""""""""""""
    " switch
    """"""""""""""""""""""""""""""
    " Ref: https://blog.othree.net/log/2017/11/16/naming-cases/
    " Switch cycling through: MACRO_CASE、lisp-case、camelCase、PascalCase、snake_case
    " default key stroke: gs
    let g:switch_custom_definitions =
      \ [
      \   {
      \     '\<\(\l\)\(\l\+\(\u\l\+\)\+\)\>': '\=toupper(submatch(1)) . submatch(2)',
      \     '\<\(\u\l\+\)\(\u\l\+\)\+\>': "\\=tolower(substitute(submatch(0), '\\(\\l\\)\\(\\u\\)', '\\1_\\2', 'g'))",
      \     '\<\(\l\+\)\(_\l\+\)\+\>': '\U\0',
      \     '\<\(\u\+\)\(_\u\+\)\+\>': "\\=tolower(substitute(submatch(0), '_', '-', 'g'))",
      \     '\<\(\l\+\)\(-\l\+\)\+\>': "\\=substitute(submatch(0), '-\\(\\l\\)', '\\u\\1', 'g')",
      \   }
      \ ]
" }}}
