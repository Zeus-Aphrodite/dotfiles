" 再読み込み
command! ReloadVimrc source $MYVIMRC
" 共通設定
source ~/.config/nvim/commons.vim

" // Plugins
" 不要なプラグインを停止する
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'haya14busa/is.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'

" 検索
Plug 'phaazon/hop.nvim'
Plug 'markonm/traces.vim'

" ファイルツリー
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

" ステータスバー
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ウィンドウサイズ
Plug 'simeji/winresizer'

" スクロール
Plug 'karb94/neoscroll.nvim'

" Colorschema
Plug 'whatyouhide/vim-gotham'

" キーマップチートシート
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Editor
" instaled coc-json, coc-kotlin
" 多様なファイル形式に対応
" Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn --frozen-lockfile'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Kotlin
Plug 'udalov/kotlin-vim'

" Dart, Flutter
Plug 'iamcco/coc-flutter', {'do': 'yarn --frozen-lockfile'}
Plug 'dart-lang/dart-vim-plugin'
" Plug 'reisub0/hot-reload.vim'
Plug 'akinsho/flutter-tools.nvim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

call plug#end()

" hop.vim
map f :HopChar2<enter>
map fw :HopWord<enter>
map fl :HopLine<enter>
map fp :HopPattern<enter>
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
hi HopNextKey guifg=#E06C75
hi HopNextKey1 guifg=#E06C75
hi HopNextKey2 guifg=#E06C75
hi HopUnmatched guifg=#4B5263

" Ctrl + / でコメントアウト
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>

" Exchange 
" nmap cx <Plug>(Exchange)
" xmap X <Plug>(Exchange)
" nmap cxc <Plug>(ExchangeClear)
" nmap cxx <Plug>(ExchangeLine)

" VSCode では無効
if !exists('g:vscode')

  " スタート画面
  let g:startify_files_number = 10
  let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'x': '~/.config/nvim/' },
            \ { 'z': '~/.zshrc' },
            \ ]
  function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
  function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
  endfunction
  let g:startify_lists = [
            \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
            \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
            \ { 'type': 'files',     'header': ['   Last Opened Files'] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
            \ { 'type': 'sessions',  'header': ['   Sessions'] },
                    \ ]

  " // fern.vim
  " ドットファイル表示
  let g:fern#default_hidden=1

  " アイコンを表示（iTerm2 のフォントを変更する必要がある）
  let g:fern#renderer = "nerdfont"

  " ツリーを開く
  nnoremap <silent> <C-q> :Fern . -width=40 -drawer -reveal=% -toggle<CR>

  " アイコンにカラーをつける
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
  function! s:init_fern() abort

    " ツリーは行番号非表示
    set nonumber

    " ツリーを閉じる
    nnoremap <silent><buffer><nowait> q :<C-u>quit<CR>
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END

  " Telescope
  nnoremap <silent> <C-o> :Telescope find_files<CR>
  nnoremap <silent> <C-g> :Telescope live_grep<CR>
  nnoremap <Leader>fb :Telescope buffers<CR>
  nnoremap <Leader>fh :Telescope help_tags<CR>

  " キーマップチートシート
  nnoremap <silent> <Leader>      :<C-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<C-u>WhichKey  ','<CR>

  " ステータスバー
  let g:airline_theme='monochrome'

  " スクロール
  lua require('neoscroll').setup()
  
  " // coc
  nnoremap <silent> <Leader>c :<C-u>CocList<CR>
  nmap <silent> <C-k> <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <s-F6> <Plug>(coc-rename)
  nnoremap K :lua vim.lsp.buf.hover()<CR>
  " nmap <silent> <Leader>a <Plug>(coc-codeaction)
  " nmap <silent> <Leader>r <Plug>(coc-refactor)
  " nnoremap gd :lua vim.lsp.buf.definition()<CR>
  nnoremap <Leader>a :lua vim.lsp.buf.code_action()<CR>
  xnoremap <Leader>a :lua vim.lsp.buf.range_code_action()<CR>

  " Dart
  nnoremap <Leader>tf :Telescope flutter commands<CR>
  let g:dart_format_on_save = 1
  augroup dart_settings
    autocmd!
    autocmd FileType dart nnoremap <silent> <buffer> <Leader>l :DartFmt<CR>
  augroup END

  function! s:trigger_hot_reload() abort
      silent exec '!kill -SIGUSR1 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
  endfunction
  
  function! s:trigger_hot_restart() abort
      silent exec '!kill -SIGUSR2 "$(pgrep -f flutter_tools.snapshot\ run)" &> /dev/null'
  endfunction
  
  command! FlutterHotReload call s:trigger_hot_reload()
  command! FlutterHotRestart call s:trigger_hot_restart()
  
  nnoremap <Leader><Leader> :FlutterRestart<CR>
  
lua << EOF
-- Flutter
require("telescope").load_extension("flutter")
require("flutter-tools").setup {
  flutter_lookup_cmd = "asdf where flutter",
  fvm = true, 
  ui = {
    border = "rounded",
  },
  widget_guides = {
    enabled = true,
  },
  dev_tools = {
    autostart = true,
    auto_open_browser = false,
  },
  outline = {
    auto_open = false
  },
  debugger = {
    enabled = false,
  },
}
require("dapui").setup()
EOF

endif

colorscheme gotham256

