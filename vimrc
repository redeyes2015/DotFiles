" :PlugInstall to install plugins.
call plug#begin()

Plug 'tpope/vim-sensible'
" Press . on a file to pre-populate it at the end of a : command line.
" also !, which starts the line off with a bang.
" Press y. to yank an absolute path for the file under the cursor.
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/vcscommand.vim'
Plug 'bling/vim-airline'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'dietsche/vim-lastplace'
" Plug 'pi314/ime.vim', {'on': 'Liu'} " ctrl-space to turn on
Plug 'Tuxdude/mark.vim'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jparise/vim-graphql'
Plug 'google/vim-jsonnet', {'for': 'jsonnet'}
Plug 'redeyes2015/gitmoji.vim', {'branch': 'main'}
Plug 'tpope/vim-commentary'
Plug 'bullets-vim/bullets.vim', {'for': 'markdown'}

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

" set omnifunc=syntaxcomplete#Complete
set omnifunc=ale#completion#OmniFunc

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

autocmd BufRead,BufNewFile *.jsonnet		set filetype=jsonnet
autocmd FileType gitcommit setlocal spell
autocmd FileType netrw nnoremap <buffer> / :keeppattern /
autocmd FileType typescriptreact,typescript,javascript,vue setlocal signcolumn=yes
autocmd FileType vue syntax sync fromstart
autocmd FileType vuejs set filetype=vue

let mapleader = ","

" Open the directory of current file in a vertical split / a new tab
nnoremap <Leader>- :Vexplore!<CR>
nnoremap <Leader>t- :Texplore<CR>

nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>vgd <Plug>(ale_go_to_definition_in_vsplit)
nmap <leader>ai <Plug>(ale_import)
nmap <leader>ad <Plug>(ale_detail)
nmap <leader>ah <Plug>(ale_hover)
nnoremap <leader>af :ALEFindReferences -relative<Return>
nnoremap <leader>ar :ALERename<Return>

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
    let g:ale_lint_on_insert_leave = 1
    let g:ale_fixers = {
                \ 'typescriptreact': ['eslint'],
                \ 'typescript': ['eslint']
                \ }
    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 1
    let g:ale_completion_autoimport = 1

    let g:ale_pattern_options = {
                \   '\.java$': {
                \       'ale_enabled': 0,
                \   },
                \}

    """"""""""""""""""""""""""""""
    " FZF customization
    """"""""""""""""""""""""""""""
    command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

    command! -bang -nargs=* GFilesFromCWD
      \ call fzf#run(fzf#wrap({
      \   'source':  'git ls-files -- .',
      \   'options': '-m --prompt "GitFilesCWD> "'
      \}))

    nnoremap <C-P> :GFilesFromCWD<CR>

    """"""""""""""""""""""""""""""
    " airline
    """"""""""""""""""""""""""""""
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.branch = ''
    let g:airline_symbols.colnr = ' C'
    let g:airline_symbols.maxlinenr = ' '

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
    " let g:ime_toggle_english='<C-@>'


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

    """"""""""""""""""""""""""""""
    " jsonnet
    """"""""""""""""""""""""""""""
    let g:jsonnet_fmt_on_save = 0 " Disable auto format on save

    """"""""""""""""""""""""""""""
    " bullets
    """"""""""""""""""""""""""""""
    let g:bullets_enable_in_empty_buffers = 0
    let g:bullets_checkbox_markers = ' .-v'
" }}}
