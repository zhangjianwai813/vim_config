"author zhangjianwai813@gmail.com
"这篇配置文档献给我认为在我职业生涯中最重要的恩师 oylbin.
" 不使用兼容vi的模式
set nocompatible
set nu
lang en_US.UTF-8
language mes en_US.UTF-8
set langmenu=en_US.UTF-8
set t_Co=256

" 获取当前路径，将$HOME转化为~
 function! CurDir()
     let curdir = substitute(getcwd(), $HOME, "~", "g")
     return curdir
 endfunction
 set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\ 
"set iskeyword=@,48-57,_,-,192-255,#
set iskeyword=@,48-57,_,192-255

"设置运行目录
set runtimepath=~/\.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/\.vim/after
"if isdirectory("/Users/mfw")
    ""set runtimepath=/Users/yeyongfa/\.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,/Users/yeyongfa/\.vim/after
    "set runtimepath=/Users/mfw/\.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,/Users/mfw/\.vim/after
    "filetype off
    "" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
    "if has("unix")
        "silent! call pathogen#runtime_append_all_bundles()
    "endif
"endif

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"

"设置vim-airline
set laststatus=2
"开启tabline
let g:airline#extensions#tabline#enabled = 1
"tabline中当前buffer两端的分隔符
let g:airline#extensions#tabline#left_sep = ' '
"tabline为激活的buffer的两端字符
let g:airline#extensions#tabline#left_alt_sep = '>'

let g:airline_theme='powerlineish'
"let g:airline_enable_branch     = 1
"let g:airline_enable_syntastic  = 1
"let g:airline_theme='kolor'
let g:tagbar_ctags_bin="/usr/local/bin/ctags"

" 自动检测文件类型
filetype plugin indent on

" 新建文件时使用的编码
set fileencoding=utf-8

" 打开文件时使用的编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big5

" 开启语法高亮
"syntax on
syntax enable
set background=dark
colorscheme solarized

" read open files again when changed outside Vim
set autoread
" write a modified buffer on each :next , ...
set autowrite

" F2 切换paste 和 nopaste 模式
" 在paste模式下粘贴文本，会保留文本原样，不会做自动缩进，自动注释等等处理。
set pastetoggle=<F2>

"折叠设置
set fdm=marker " 对文中的标志折叠
set fdc=2

"行控制
set linebreak " 英文单词在换行时不被截断
set textwidth=119 " 设置每行119个字符自动换行，加上换行符
"set wrap " 设置自动折行
set formatoptions=tcrwa "q：允许使用"gq"命令对注释进行格式化；r：插入模式下在注释中键入回车时，插入合适的注释起始字符；n：识别编号列表，编号行的下一行的缩进由数字后的空白决定（与"2"冲突，需要"autoindent"）；t：根据textwidth自动折行；
set colorcolumn=120
let g:indent_guides_guide_size=1

"光标当前列高亮
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

" When I close a tab, remove the buffer
set nohidden

" 更好的命令自动提示菜单
set wildmenu

" 显示标尺
set ruler

" 自动缩进 
set autoindent
"set smartindent

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" <TAB> 自动转换为4个空格
set tabstop=4
" 统一缩进为4个空格
set softtabstop=4
set shiftwidth=4
" 在行和段开始处使用制表符
set smarttab

set expandtab

" 不创建备份文件
set nobackup

" 搜索时边键入边搜索
set incsearch

" 高亮所有搜索匹配项
set hlsearch

" 忽略大小写
set ignorecase
"set smartcase

" backspacing over everything in insert mode
set backspace=indent,eol,start  

"set foldmethod=indent

" No sound on errors
set noerrorbells
"set novisualbell
set t_vb=


" vimrc被修改时自动重新加载
autocmd! bufwritepost .vimrc source %




let mapleader=","

" 去除上次搜索后的高亮
nnoremap <leader><space> :noh<cr>

"tagbar的启动
nmap <leader>b :TagbarToggle<CR>

"设置界面分割
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWindowLayout = "FileExplorer|TagList,BufExplorer"
"设置winmanager的宽度，默认为25
let g:winManagerWidth = 30
"定义打开关闭winmanager按键
nnoremap <leader>u :WMToggle<cr>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

nnoremap <tab> %
vnoremap <tab> %

" 选中刚刚粘贴的行
nnoremap <leader>v V`]

"inoremap <Esc> <nop>
" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

"au BufRead,BufNewFile *.mk		set ft=markdown


if v:version >= 702
    " 调用php 检查当前文件的语法
    map <F5> :call Execute_Script()<CR>
    map <leader>r :call Execute_Script()<CR>

    function! Execute_Script()
        :w
        if &filetype == 'php'
            let s:php_script_name=expand("%")
            if strpart(s:php_script_name,strlen(s:php_script_name)-8)=="Test.php"
                execute '!phpunit %'
            else
                execute '!php %'
            endif
        elseif &filetype == 'python'
            execute '!python %'
        elseif &filetype == 'sh'
            execute '!bash -ex %'
        elseif &filetype == 'make'
            :make
        elseif &filetype == 'markdown' || &filetype == 'notes' 
            execute '!pandoc -f markdown -t html % > /tmp/markdown.html'
            execute '!open -a "Google Chrome.app" file:///tmp/markdown.html'
            "execute '!x-www-browser file:///tmp/markdown.html'
        elseif &filetype == 'lua'
            execute '!lua %'
        endif
    endfunction
endif

map <F4> :Ack <C-R><C-W> .
map <F3> :grep <C-R><C-W> .

" 在新tab打开当前文件所在的目录
map <F6> :tabnew %:p:h<CR>
map <leader>o :tabnew %:p:h<CR>

"map <leader>f :tabnew<cr>:FufFile<cr>
map <leader>f :FufFile<cr>
"map <leader>f :<C-U>CtrlP<CR>


map <leader>q :q<cr>
nmap <leader>w :w!<cr>

nmap <leader>n :tabnew /data/work/src/wiki/wiki/<cr>

"vmap <leader>c "+y
"vmap <leader>x "+x
"map <leader>d :!screen bash -c "cd \"`pwd`\" && exec $SHELL --login"<cr>
nnoremap <space> :cn<cr>





map <leader>it O<CR><C-R>=strftime("%Y-%m-%d %H:%M")<CR><CR>
map <leader>id a<C-R>=strftime("%Y-%m-%d")<CR><Esc>
map <C-H> gT
map <C-L> gt

"标签左右切换
"map <left> gT
"map <right> gt
map nn gT
map mm gt

"行尾
map ff $
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

autocmd filetype php call Set_php_options()
autocmd filetype lua call Set_lua_options()
function! Set_php_options() 
    set keywordprg="help"
    map <leader>t :!phpunit %<cr>
    map <leader>T :!phpunit --filter <C-R><C-W> %<cr>
    map <leader>c :!php -l %<CR>
    set dictionary-=~/.vim/php_funclist.txt dictionary+=~/.vim/php_funclist.txt
    set complete-=k complete+=k
endfunction
function! Set_lua_options() 
    map <leader>c :!luac -p %<CR>
endfunction

let g:debuggerPort = 9001
map <S-Insert> "+p
inoremap <S-Insert> <esc>"+pa

nnoremap <leader><space> :noh<cr>

let g:html_indent_inctags = "html,body,head,tbody"

 
command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')


set clipboard=unnamed
if &diff
    set background=dark
    "colorscheme peaksea
else
    "set background=dark
    "colorscheme desert
endif

cmap w!! w !sudo tee % >/dev/null

" 为了mac下面能够正确的编辑crontab
au BufEnter /private/tmp/crontab.* setl backupcopy=yes


map <leader>l :Tlist<cr>
map <leader>a :TagbarToggle<CR>
nmap <F9> :tabs<CR>


" OmniCppComplete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
set tags=./tags
set tags+=~/.vim/bundle/OmniCppComplete/tags/cpp
let OmniCpp_NamespaceSearch = 1 " 打开命名空间
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters | 打开显示函数原型
let OmniCpp_MayCompleteDot = 1 " autocomplete after . | 打开  . 操作符
let OmniCpp_MayCompleteArrow = 1 " autocomplete after -> | 打开 -> 操作符
let OmniCpp_MayCompleteScope = 1 " autocomplete after :: | 打开 :: 操作符
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_SelectFirstItem = 1
let OmniCpp_ShowScopeInAbbr = 0

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview " 关掉智能补全时的预览窗口.缺省的，vim会使用下拉菜单和一个preview窗口(预览窗口)来显示匹配项目，下拉菜单列出所有匹配的项目，预览窗口则显示选中项目的详细信息。打开预览窗口会导致下拉菜单抖动，因此我一般都去掉预览窗口的显示，这需要改变’completeopt‘的值。

"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
"inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
"
"vnoremap ( s()<Esc>P<Right>%
"vnoremap [ s[]<Esc>P<Right>%
"vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"map <M-h> <C-T>
"map <M-l> <C-]>

let tlist_objc_settings    = 'objc;i:interface;c:class;m:method;p:property'

autocmd BufRead,BufNewFile *.mm :set ft=objc
autocmd BufRead,BufNewFile *.m :set ft=objc

if has("gui_running")
    set go-=T
    set go-=m
    set guifont=Monaco:h14
    colorscheme peaksea
    win 140 40
    winp 200 0
endif

let g:lua_complete_omni = 0
map <left> gT
map <right> gt

let g:ctrlp_open_new_file = 't'
let g:ctrlp_map = '<C-p>'
"set ffs=unix,mac,dos

"function! MarkdownLevel() 
"    let h = matchstr(getline(v:lnum), '^#\+')
"    if empty(h) 
"        return "=" 
"    else 
"        return ">" . len(h) 
"    endif 
"endfunction
"if &diff
"else
"    au BufEnter *.markdown setlocal foldexpr=MarkdownLevel()  
"    au BufEnter *.markdown setlocal foldmethod=expr  
"endif
"
"
"语法检查插件设置
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
