call plug#begin('~/.vim/plugged')
"on 当执行func的时候加载该插件
"for 当文件类型为type的时候加载该插件
"do 当安装/升级完该插件后执行某脚本
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
" 可以使 nerdtree 的 tab 更加友好些
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
"快速注释
Plug 'preservim/nerdcommenter'
"Commentary 可视化注释
Plug 'junegunn/fzf'
Plug 'jiangmiao/auto-pairs'
"Plug 'bling/vim-bufferline'
"Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'prasada7/toggleterm.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-syntastic/syntastic', { 'for': 'python' }
Plug 'vim-scripts/winmanager'
call plug#end()

let g:coc_global_extensions = [ 'coc-sh', 'coc-vimlsp', 'coc-python', 'coc-json', 'coc-highlight' ]
let NERDTreeShowHidden=1
"快捷键开关目录
map <F2> :NERDTreeToggle<CR>
"多行注释
nmap // <leader>ci <CR>
"airline conf
let g:airline_theme='dark'
"分隔符
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '/'
let g:airline_symbols.branch = '↰↱'
"打开buferline 
"开启tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"激活彩虹括号
let g:rainbow_active = 1

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

"关闭兼容vi模式
set nocompatible
set history=50
set ruler
set noswapfile

"开启语法高亮
syntax enable
set background=dark
"设置主题
if filereadable(expand("~/.vim/plugged/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    colorscheme solarized
elseif filereadable(expand("~/.vim/plugged/vim-monokai/colors/monokai.vim"))
    colorscheme monokai
else
    colorscheme desert
endif
"高亮搜索结果
set hlsearch
"支持文件类型检查及基于文件类型的插件
filetype plugin on
au BufRead,BufNewFile *.txt setlocal ft=txt

set term=xterm-256color
set t_Co=256

"设置行号
set number
set rnu
augroup NumToggle
    autocmd!
    "i模式时绝对行号，退出i模式使用相对行号
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

"突出显示当前行
set cursorline
"显示括号匹配
set showmatch
set backspace=2
set backspace=indent,eol,start
"开启实时搜索
set incsearch
"搜索时大小写不敏感
set ignorecase
"搜索时智能大小写敏感，仅搜索首字母大写时敏感
set smartcase
" 表示一个 tab 显示出来是多少个空格的长度，默认 8
set tabstop=4
" 空格替换tab
set expandtab
" 表示在编辑模式的时候按退格键的时候退回缩进的长度，配合expandtab使用
set softtabstop=4
" 表示每一级缩进的长度，一般设置成跟 softtabstop 一样
set shiftwidth=4
" autoindent 插入一个新行时，将依据上一行缩进而缩进,如果你在新行没有输入任何字符，那么这个缩进将自动删除。
" cindent 会按照 C 语言的语法，自动地调整缩进的长度
set autoindent

set foldmethod=indent
set foldlevelstart=99

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
map <Esc-l> :nohl <CR>

"粘贴时保持原格式
set pastetoggle=<F9>
"默认分割的新窗口在本窗口下方
"set splitbelow
"设置terminal高度为10，宽度默认
"set termwinsize=10x0
"打开terminal
map <F1> :bot term ++rows=10 <CR>
"关闭terminal
tmap <F8> <C-W>:call CloseTerm()<CR>
nmap <F8> <C-W>p<C-W>:call CloseTerm()<CR>
func! CloseTerm()
    "feedkeys 在vim/neovim中都有，但是有可能会被vim截获
    call feedkeys('exit'. "\<CR>")
    "term_sendkeys仅在vim中，但是直接向内置终端键入
    "call term_sendkeys('', 'exit'. "\<CR>")
endfunc

map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'sh'
    	:!time bash %
    elseif &filetype == 'python'
	    exec "!time python %"
    elseif &filetype == 'php'
    	exec "!time php -f %"
    elseif &filetype == 'c'
    	exec "!g++ % -o %<"
	    exec "!time ./%"
    elseif &filetype == 'cpp'
    	exec "!g++ % -o %<"
	    exec "!time ./%"
    elseif &filetype == 'java'
    	exec "!javac %"
	    exec "!java %<"
    endif
endfunc

autocmd BufNewFile *.sh,*.py,*.cpp,*.[ch],*.java,*.hpp exec ":call AddHeader()"
func AddHeader()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call append(line(".")+1, "")
        call append(line(".")+2, "")
    elseif &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(line("."), "\# -*- coding: UTF8 -*-")
        call append(line(".")+1, "")
        call append(line(".")+2, "")
	elseif &filetype == 'cpp'
        call setline(1, "\#include<iostream>")
        call append(line("."), "using namespace std;")
        call append(line(".")+1, "")
    elseif &filetype == 'c'
        call setline(1, "\#include<stdio.h>")
        call append(line("."), "")
	elseif expand("%:e") == 'hpp'
        call setline(1, "/** ")
    endif
endfunc
autocmd BufNewFile * normal G
