"设置 mapleader
let mapleader = ','

"===================================================
".vimrc 相关
"===================================================
"重新加载 .vimrc
map <silent> <leader>ss : source ~/.vimrc<cr>

"快速编辑 .vimrc
map <silent> <leader>ee : e ~/.vimrc<cr>

"自动命令，每次编辑.vimrc后重新加载它
autocmd! bufwritepost .vimrc source ~/.vimrc

"===================================================
"总体设置
"===================================================
" 突出显示当前列
set cursorcolumn

" 突出显示当前行
set cursorline

"文件更新后自动读入
set autoread

"设置鼠标可用
set mouse=a 

"显示行号
set number

"设置记忆历史数目
set history=500

"显示当前位置
set ruler

"设置命令栏高度
set cmdheight=2

"搜索时忽略大小写
set ignorecase

"智能搜索
set smartcase

"搜索结果高亮显示
set hlsearch

"括号匹配和闪烁时间
set showmatch
set mat=2

"关闭声音
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"===================================================
"显示相关
"===================================================
"语法高亮
syntax enable
syntax on

"配色方案
set background=dark
"colorscheme peaksea

"===================================================
"文本，制表符和缩进相关
"===================================================
"使用空格不使用制表符
set expandtab

"智能使用制表符
set smarttab

"一个tab为四个空格
set shiftwidth=4
set softtabstop=4
set tabstop=4

"500个字符自动换行
set lbr
set tw=500
"自动缩进
"set ai
"智能缩进
"set si
"换行
"set wrap

"====================================================
"移动，标签，窗口和缓冲区
"====================================================
"切换窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"始终显示状态行
set laststatus=2

"====================================================
"编辑相关
"====================================================
"括号补全
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap < <><esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i

"====================================================
"Python相关
"====================================================
let python_highlight_all = 1

au BufNewFile,BufRead *.py,*.pyw setf python

au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja

au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#

"=====================================================
"插件
"=====================================================
"开启插件
filetype plugin indent on

"flake8关闭时自动检查
autocmd BufWritePost *.py call flake8#Flake8()

"====================================================================================================
"Vundle插件管理
"====================================================================================================
set nocompatible
"filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Bundle 'Valloric/YouCompleteMe' 
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'winmanager'
Bundle 'jiangmiao/auto-pairs'
Bundle 'nvie/vim-flake8.git'

call vundle#end() " required
filetype plugin indent on

"===================================================================================================
"YouCompleteMe
"===================================================================================================
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'

set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=3	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

"===================================================================================================
"Nerdtree
"===================================================================================================
" 文件树设置 {{{
" 关闭NERDTree快捷键
map <leader>t :NERDTreeToggle<CR>
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=30
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}

"===================================================================================================
"Tagbar
"===================================================================================================
"安装tagbar插件  
""设置tagbar使用的ctags的插件,必须要设置对  
let g:tagbar_ctags_bin='/usr/bin/ctags'  
"设置tagbar的窗口宽度  
let g:tagbar_width=27
""设置tagbar的窗口显示的位置,为左边  
let g:tagbar_right=1  
"打开文件自动 打开tagbar  
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py call tagbar#autoopen()  
""映射tagbar的快捷键  
map <C-c> :TagbarToggle<CR> 

"===================================================================================================
"winmanager
"==================================================================================================
" 设置界面分割
let g:winManagerWindowLayout = "TagList|FileExplorer"
"设置winmanager的宽度，默认为25
let g:winManagerWidth = 25
"定义打开关闭winmanager快捷键为F8
nmap <silent> <F8> :WMToggle<cr>
"在进入vim时自动打开winmanager
"let g:AutoOpenWinManager = 1

"===================================================================================================
"添加个人信息
"==================================================================================================
map <F4> :call HeadSet()<cr>

function! AddHead()
    if &filetype == 'python'
    call append(0,"\#!/usr/bin/python ")
    call append(1,"# ******************************************************")
    call append(2,"# Author       : CoffreLv")
    call append(3,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(4,"# Email        : coffrelv@163.com")
    call append(5,"# Filename     : ".expand("%:t"))
    call append(6,"# Description  : ")
    call append(7,"# ******************************************************")
    else
    call append(0,"# ******************************************************")
    call append(1,"# Author       : CoffreLv")
    call append(2,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(3,"# Email        : coffrelv@163.com")
    call append(4,"# Filename     : ".expand("%:t"))
    call append(5,"# Description  : ")
    call append(6,"# ******************************************************")
    endif
    echohl WarningMsg | echo "Successful in adding copyright." | echohl None
endfunction
 
function! UpdateHead()
     normal m'
     execute '/# Last modified/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
     normal ''
     normal mk
     execute '/# Filename/s@:.*$@\=":\t".expand("%:t")@'
     execute "noh"
     normal 'k
     echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction

function! HeadSet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified\S*.*$'
            call UpdateHead()
            return
        endif
        let n = n + 1
    endwhile
    call AddHead()
endfunction
