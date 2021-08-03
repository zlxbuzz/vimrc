" 禁止生成 swap 恢复文件
set noswapfile
" vim 内部使用的编码，默认使用 latin1，改成通用的 utf8 编码，避免乱码
set encoding=utf-8
" 文件编码探测列表
" vim 启动的时候会依次使用本配置中的编码对文件内容进行解码
" 如果遇到解码失败，则尝试使用下一个编码
" 常见的乱码基本都是 windows 下的 gb2312, gbk, gb18030 等编码导致的
" 所以探测一下 utf8 和 gbk 足以应付大多数情况了
set fileencodings=utf-8,gb18030
" 修正 vim 删除/退格键行为
" 原生的 vim 行为有点怪：
" 如果你在一行的开头切换到插入模式，这时按退格无法退到上一行
" 如果你在一行的某一列切换到插入模式，这时按退格无法退删除这一列之前的字符
" 如果你开启了 autoindent，按回车时 vim 会根据上一行自动缩进
" 这时按退格无法删除缩进字符
" 通过设置 eol, start 和 indent 可以修正上述行为
set backspace=eol,start,indent
" vim 默认使用单行显示状态，但有些插件需要使用双行展示，不妨直接设成 2
set laststatus=2
" 高亮第 80 列,会有一个竖线
set colorcolumn=80
" 高亮光标所在行
set cursorline
" 显示窗口比较小的时候折行展示
set linebreak
" 在插入模式按回车时 vim 会自动根据上一行的缩进级别缩进
set autoindent
" 智能大小写
set ignorecase
set smartcase
" 显示标尺
set ruler
" 输入命令显示
set showcmd
" tab长度
set tabstop=4
" 设置缩进 
set shiftwidth=2
" 搜索逐渐高亮
set incsearch
" 高亮匹配括号
set showmatch
" 标记折叠
set foldmethod=manual
" 开启行号显示
set number
" 历史记录数
set history=10000


" 开启自动识别文件类型，并根据文件类型加载不同的插件和缩进规则 
filetype plugin indent on
" 语法高亮
syntax on

" 开启 24 位真彩色支持
" set termguicolors
" 配色Vim为256
set t_Co=256
" 背景设置
set background=light
" 主题色
colorscheme solarized

nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeFind<cr>
nnoremap <silent> <leader>c :call lv#Term()<cr>

function! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let name = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	return empty(name) ? '[No Name]' : name
endfunction

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		let s .= ' '. (i+1) . ' '
		let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	endfor
	return s
endfunction
set tabline=%!MyTabLine()




" 插件配置
" NERDTree
" 后面跟文件则不打开目录结构
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 默认是否用 l 代替 o 打开文件
let g:NERDTreeMapActivateNode= 'l'
let g:NERDTreeMapMenu = 'o'

" indentline
" 分隔符富豪
let g:indentLine_char = '┊'
" json展示双引号
autocmd FileType json,markdown let g:indentLine_conceallevel = 0


" tcommment_vim
" 代码注释
noremap  <Leader>x :TComment<cr>
noremap  <Leader>X :TCommentRight<cr>
xnoremap <Leader>x :TCommentMaybeInline<cr>
noremap  <Leader>C :TCommentMaybeInline<cr>
noremap  <Leader>c :TCommentBlock<cr>
xnoremap <Leader>c :TCommentBlock<cr>

" neoformat
" 自动保存格式化
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
let g:neoformat_run_all_formatters = 1


" vim-vue
autocmd BufReadPre *.vue packadd vue

" airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'

" typescript-vim 
autocmd BufReadPre *.ts packadd ts-vim
autocmd BufReadPre *.ts packadd Tsuquyomi 

" youcompelteme 
" let g:ycm_min_num_of_chars_for_completion = 3 
" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_complete_in_comments = 1
" let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
" 比较喜欢用tab来选择补全...
function! MyTabFunction ()
    let line = getline('.')
    let substr = strpart(line, -1, col('.')+1)
    let substr = matchstr(substr, "[^ \t]*$")
    if strlen(substr) == 0
        return "\<tab>"
    endif
    return pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
endfunction
inoremap <tab> <c-r>=MyTabFunction()<cr>

" tsuquyomi
" leader + t 展示光标所在类型
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>



