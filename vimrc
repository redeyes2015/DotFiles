
set nocompatible

" :PlugInstall to install plugins.
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'pangloss/vim-javascript'
Plug 'vcscommand.vim'
Plug 'briancollins/vim-jst', {'for': 'jst'}
Plug 'bling/vim-airline'
"Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'dietsche/vim-lastplace'
Plug 'pi314/boshiamy.vim', {'on': 'Liu'}
"Plug 'yuttie/comfortable-motion.vim'
Plug 'Tuxdude/mark.vim'

Plug 'flazz/vim-colorschemes'

"Plugin 'evanmiller/nginx-vim-syntax'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ General settings over vim-sensible]                                      {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set ignorecase
set smartcase

set splitright
set switchbuf=usetab
set gdefault

" hi Visual cterm=NONE ctermbg=White ctermfg=Black
" hi Search cterm=NONE ctermbg=White ctermfg=Black

set t_Co=256
set background=dark
colorscheme peaksea

" To avoid issues with gulp.watch
" see: https://github.com/nodejs/node-v0.x-archive/issues/3172
autocmd BufWritePre */project*   setlocal backupcopy=yes

autocmd FileType gitcommit setlocal spell

let mapleader = ","

" insert a blank line without entering insert mode
nnoremap <Leader>O O<ESC>j
nnoremap <Leader>o o<ESC>k

" Open the directory of current file in a vertical split / a new tab
nnoremap <Leader>- :Vexplore!<CR>
nnoremap <Leader>t- :Texplore<CR>

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

inoremap          <C-R>/ <C-R>=Del_word_delims()<CR>
cnoremap          <C-R>/ <C-R>=Del_word_delims()<CR>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Plugin configuration ]                                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""
    " syntastic
    """"""""""""""""""""""""""""""
    let g:syntastic_javascript_checkers=['eslint']
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_auto_loc_list = 1


    """"""""""""""""""""""""""""""
    " ctrlp
    """"""""""""""""""""""""""""""
    let g:ctrlp_working_path_mode = 'rc'
    let g:ctrlp_root_markers = ['Makefile']
    let g:ctrlp_custom_ignore = {
      \ 'dir': 'node_modules',
      \ }

" }}}
