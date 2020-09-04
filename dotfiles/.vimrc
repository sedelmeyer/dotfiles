"Set compatibility to Vim only.
set nocompatible

"Show line numbers
set number
set relativenumber

"Encoding
set encoding=utf-8

"Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

"Set window split preferences
set splitbelow
set splitright

"split navigation key mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Enable folding
set foldmethod=indent
set foldlevel=99

"Python specific settings
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=88 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" make backspaces more powerfull
set backspace=indent,eol,start

"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Show file options above the command line
set wildmenu

" Set the working directory to wherever the open file lives
set autochdir

"Autoload vim-plug plugin manager if it isn't already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Install plugins using vimplug

"Specify a directory for plugins
"- For Neovim: stdpath('data') . '/plugged'
"- Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"Make sure you use single quotes

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tomasiser/vim-code-dark'

"Initialize plugin system
call plug#end()

"Gitgutter settings
let g:gitgutter_set_sign_backgrounds = 1
"increase frequency of vim update time to 100ms to capture changes sooner
set updatetime=100

"Limelight is activated only during Goyo session
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"Make non-focused text in goyo session light gray color
let g:limelight_conceal_ctermfg = 240

"Reload .vimrc to restore preferred defaults when exiting Goyo
autocmd! User GoyoLeave source ~/.vimrc

"set color scheme
syntax on
colorscheme codedark

"Configure statusline how I want it to look
"First remove showmode because the statusline will do that
set noshowmode

"Now configure statusline
set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%{StatuslineMode()}
set statusline+=%1*
set statusline+=\ 
set statusline+=<
set statusline+=<
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=>
set statusline+=>
set statusline+=%=
set statusline+=%m
set statusline+=%h
set statusline+=%r
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
set statusline+=%1*
set statusline+=\ 
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=:
set statusline+=%c
set statusline+=\ 
set statusline+=%1*
set statusline+=%y
hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User1 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
hi User4 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
hi User5 ctermbg=black ctermfg=magenta guibg=black guifg=magenta

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"Add ALE linter errors to status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \}

let g:ale_fixers = {
      \    'python': ['black', 'isort'],
      \}
" nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
