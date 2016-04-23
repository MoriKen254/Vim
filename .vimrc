"--------1---------2---------3----------4---------5---------6---------7---------8---------9---------0
"****************************************************************************************************
"" Neobundle インストール設定
set nocompatible
filetype off

if has('vim_starting')
	" 初回起動時のみruntimepathにneobundleのパスを指定する
	set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

" NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))
" インストールするプラグインをここに記述
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim' " 最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\ 'windows' : 'make -f make_mingw32.mak',
			\ 'cygwin' : 'make -f make_cygwin.mak',
			\ 'mac' : 'make -f make_mac.mak',
			\ 'unix' : 'make -f make_unix.mak',
			\ },
			\ }
"Neobundle 'Shougo/vimshell.vim
NeoBundleLazy 'Shougo/vimshell', {
			\ 'depends' : 'Shougo/vimproc',
			\ 'autoload' : {
			\   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
			\                 'VimShellExecute', 'VimShellInteractive',
			\                 'VimShellTerminal', 'VimShellPop'],
			\   'mappings' : ['<Plug>(vimshell_switch)']
			\ }}
NeoBundle 'osyo-manga/vim-reunions'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'nathanaelkane/vim-indent-guides'                 " インデントハイライトプラグイン
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'taketwo/vim-ros'
NeoBundle 'gregsexton/gitv.git'
NeoBundle 'justmao945/vim-clang'
call neobundle#end()
" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

NeoBundleCheck


"****************************************************************************************************
"--------1---------2---------3----------4---------5---------6---------7---------8---------9---------0
"****************************************************************************************************
"" Neobundle 詳細設定

""" lightline {{{
set guifont=Ricty\ 10

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'component': {
"      \   'readonly': '%{&readonly?"x":""}',
"      \ },
"      \ 'separator': { 'left': '', 'right': '' },
"      \ 'subseparator': { 'left': '|', 'right': '|' }
"      \ }

set laststatus=2
set t_Co=256
"""}}}

"""gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

""" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" docstringは表示しない
autocmd FileType python setlocal completeopt-=preview
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
""""}}}

""" Unite {unite_source_history_yank_enable{{
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" yank内容をヒストリからさかのぼって貼り付けられる
let g:unite_source_history_yank_enable =1

" unite 起動
nnoremap <silent> ,un  :<C-u>Unite<CR>
" grep検索
nnoremap <silent> ,ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,ucg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出
nnoremap <silent> ,ur  :<C-u>UniteResume search-buffer<CR>
" 最近使ったファイルとバッファを表示
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> ,ud :<C-u>Unite<Space>directory_mru<CR>
" yanの履歴を表示
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
" 現在のバッファを表示
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" カレントディレクトリを表示
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧を表示
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
" }}}

""" vimshell {{{
nmap <silent> ,vs :<C-u>VimShell<CR>
nmap <silent> ,vp :<C-u>VimShellPop<CR>
" }}}

""" vimfiler {{{
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
nmap <silent> ,vf :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
" }}}

""" fugitive {{{
" Gstatus 起動
nnoremap <silent> ,gs  :<C-u>Gstatus<CR>
" Gread 起動
nnoremap <silent> ,gr  :<C-u>Gread<CR>
" Gcommit 起動
nnoremap <silent> ,gc  :<C-u>Gcommit<CR>
"}}}

""" gitv {{{
" Gitv ブラウザモード起動
nnoremap <silent> ,gv  :<C-u>Gitv<CR>
" Gitv ファイルモード起動
nnoremap <silent> ,gf  :<C-u>Gitv!<CR>
"}}}

let g:seiya_auto_enable=1

""" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=25
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=22
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"let g:indent_guides_auto_colors=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_guide_size=1
" }}}

""" vim-easymotion {{{
"<Leader>をスペースに設定
let mapleader = "\<Space>"
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'ASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
hi EasyMotionTarget guifg=#80a0ff ctermfg=81

" easy-motionのトレーニング
function! StartEMTraining ()
  noremap h <Nop>
  noremap j <Nop>
  noremap k <Nop>
  noremap l <Nop>
endfunction

" easy-motionのトレーニング解除
" ＿人人人人人人人＿
" ＞　非推奨！！　＜
" ￣Y^Y^Y^Y^Y^Y￣
function! StopEMTraining ()
  nnoremap h <Left>
  nnoremap j gj
  nnoremap k gk
  nnoremap l <Right>
endfunction
" }}}

command! StartEMTraining call StartEMTraining()
command! StopEMTraining call StopEMTraining()

" デフォルトはトレーニングモード"
"call StartEMTraining()
call StopEMTraining()

"****************************************************************************************************
"--------1---------2---------3----------4---------5---------6---------7---------8---------9---------0
"****************************************************************************************************
""" jedi-vim(python complete) {{{
autocmd filetype python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
"""}}}

" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
let g:python_highlight_all = 1
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '\h\w*\|[^. \t]\.\w*'
      "\ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '\h\w*\|[^. \t]\.\w*'
      "\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 0

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
    let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
    let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
    let g:clang_exec = 'clang-3.4'
else
    let g:clang_exec = 'clang'
endif

if executable('clang-format-3.6')
    let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
    let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
    let g:clang_format_exec = 'clang-format-3.4'
else
    let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

" }}}

"****************************************************************************************************
"--------1---------2---------3----------4---------5---------6---------7---------8---------9---------0
"****************************************************************************************************
"" vim 標準設定
""" 中間ファイル設定 {{{
set nobackup                           "~の作成無効化
set writebackup                        "上書き成功時に~を削除
"""}}}

""" クリップボード設定 {{{
set guioptions+=a                      "クリップボードを共有(gvim用)
set clipboard+=unnamed,autosele        "クリップボードを共有
set clipboard=unnamedplus              "クリップボードを共有
"""}}}

""" スペルチェック {{{
"set spelllang=+cjk
"set spell
"""}}}

""" 操作設定 {{{
set mouse=a                            " 全モードでマウス利用可能
set ttymouse=xterm2                    " マウスホイール利用可能
set backspace=start,eol,indent         " backspace で削除可能
set incsearch                          " インクリメンタル検索
set wildmenu wildmode=list:full        " コマンドラインモード補完機能
set whichwrap=b,s,h,l,<,>,[,],~        " 横移動で行を移動できるようにする
set showcmd                            " 入力中のコマンドを表示する
"virtualモードの時にスターで選択位置のコードを検索するようにする"
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
"""}}}

""" 文字設定 {{{
set encoding=utf-8                     "vim
scriptencoding utf-8
set fileencoding=utf-8                 "保存するファイル
set termencoding=utf-8                 "開くファイル
set softtabstop=4                      " タブによる半角文字数
set shiftwidth=4                       "インデント幅
set expandtab
set smartindent                        "挿入モードでタブ文字有効
set smarttab	
"""}}}

""" 表示設定 {{{
syntax on                              "ハイライト表示
set number                             "タイトル
set title                              "行番号
set nohlsearch                         " 検索時ハイライトなし
set cursorline                         " カーソル行ハイライト
"""}}}

""" カラースキーマ設定 {{{
set t_Co=256
colorscheme molokai
let g:molokai_original=1
set background=dark
"highlight Comment ctermfg=LightCyan 
" 背景黒字のハイライト色を設定
highlight Normal ctermbg=black ctermfg=white
highlight statusline term=none cterm=none ctermfg=black ctermbg=grey
highlight cursorline term=none cterm=none ctermfg=none ctermbg=black
"highlight cursorline term=none cterm=none ctermfg=none ctermbg=darkgray
"""}}}

""" キーバインド設定 {{{

"""" normal mode ****
"""" ノーマルモードでのカーソル移動 {{{{
nnoremap <S-h> ^
nnoremap <S-j> )
nnoremap <S-k> (
nnoremap <S-l> $
"""}}}}

"""" find highlight cancel {{{{
nmap <silent> nh :<C-u>noh<CR>
"""" }}}}

""""ESCでIMEを確実に解除 {{{{
inoremap <silent> <ESC> <ESC>:call ForceImeOff()<CR>
function! ForceImeOff()
	let imeoff = system('xvkbd -text "\[Control]\[Shift]\[space]" > /dev/null 2>&1')
endfunction
"""" }}}}

"""" insert mode ****
"""" normalモードで上下左右ボタンを矯正無効化 {{{{
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
"""" }}}}

"""" insertモードから抜ける {{{{
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
inoremap <silent> hh <ESC>
"""" }}}}

"""" 挿入モードでのカーソル移動 {{{{
"inoremap <C-k> <Up>
"inoremap <C-j> <Down>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>
"""" }}}}

"""" command mode ****
"""" コマンドモードで履歴フィルタリング {{{{
" 履歴前方参照
cnoremap <C-p> <Up>
" 履歴後方参照
cnoremap <C-n> <Down>
" カーソル右移動
cnoremap <c-f> <Right>
" カーソル左移動
cnoremap <c-b> <Left>
" カーソル先頭へ移動(末尾はデフォルトでc-e)
cnoremap <c-a> <Home>
" 現在のディレクトリを入力
cnoremap <expr> %% (getcmdtype() == ':') ? expand('%:h').'/' : '%%'
" 置換を簡単にしたい
cnoremap <expr> ,r (getcmdtype() == ':') ? '%s///gc' : ',r'
"""" }}}}


"****************************************************************************************************
"--------1---------2---------3----------4---------5---------6---------7---------8---------9---------0
"****************************************************************************************************
""" Vim-LaTeX {{{ 
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'upmendex $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
"let g:Tex_ViewRule_pdf = 'xdg-open'
let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
"let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'
""" }}}
