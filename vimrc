" 避免一些bug
set nocompatible
" 语法高亮
syntax enable

" 文件检测
filetype on

" 对相关文件载入插件 缩进
filetype plugin indent on

" 相关缩进，自动合并两行等
set backspace=indent,eol,start
" 为C程序提供自动缩进
set smartindent
" 显示标尺
set ruler
" 开启行号显示
set number
" 输入命令显示
set showcmd
" 空格代替tab
set expandtab
" 缩进为4
set shiftwidth=2
" 搜索逐渐高亮
set incsearch
" 高亮匹配括号
set showmatch
" 标记折叠,关闭后不会消失
set foldmethod=marker
" 历史记录数
set history=10000

" 命令行自动显示全部
set wildmenu
set wildmode=full
"禁止生成临时文件
set nobackup
set noswapfile

" 文件编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 配色Vim为256
set t_Co=256
set bg=dark


set laststatus=2

" tab长度
set tabstop=4

" 搜索忽略大小写
set ignorecase

" 背景设置
set background=light


call plug#begin('~/.vim/plugged')
" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'

" 代码分割线
Plug 'yggdroot/indentline'

" 主题颜色
Plug 'altercation/vim-colors-solarized'

" 目录结构
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" 文件搜索
Plug 'ctrlpvim/ctrlp.vim'

" 快速定位
Plug 'easymotion/vim-easymotion'
nmap ss <Plug>(easymotion-s2)

" 模糊搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 代码大纲
Plug 'majutsushi/tagbar'

" 代码格式化
Plug 'sbdchd/neoformat'
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" 注释
Plug 'tpope/vim-commentary'

" coc插件体系
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" 颜色选择 放到end之后
colorscheme solarized

" 后面跟文件则不打开目录结构
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
