" Move cursor by virtual lines.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap Y y$
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" cmdline-editing
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-l> <Delete>
cnoremap <C-d> <S-Left>
cnoremap <C-f> <S-Right>

" Insert a newline in normal mode.
nnoremap <CR> o<ESC>k
" Move the current line one down.
nnoremap <silent> <C-j> :m+1<Bar>echo 'Move line down'<CR>
" Move the current line one up.
nnoremap <silent> <C-k> :m-2<Bar>echo 'Move line up'<CR>

" Toggle displaying whitespaces. Mapped to 'ctrl + /'
nnoremap <silent> <C-_> :set nolist!<Bar>echo 'Show whitespaces'<CR>
" Commentate
vnoremap <C-_> :call Commentate()<CR>

" Removes any search highlighting.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Insert space in normal mode
nnoremap <space> i<space><ESC>
" Copy & Paste
vnoremap <C-c> "+y:echo 'Yanked to clipboard'<CR>
inoremap <C-v> <ESC>"+pa

" Cycle through buffers
nnoremap <silent> gt :silent bn<Bar>echo @%<CR>
nnoremap <silent> gT :silent bp<Bar>echo @%<CR>
nnoremap <silent> <BS> :silent bd<Bar>echo @%<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [g :lnext<CR>
nnoremap <silent> ]g :lprev<CR>

" Escape terminal mode
let g:termdebug_useFloatingHover = 0
let g:termdebug_use_prompt = 1
tnoremap <Esc> <C-\><C-n>
nnoremap <RightMouse> :Break<CR>

" Reverse selected lines.
vnoremap <leader>r y:call ReverseLines()<Bar>echo 'Reversed lines'<CR>
" External Utilities
nnoremap <leader>1 :.!toilet -w 200 -f term -F border<CR>

" Run fuzzy finder
nnoremap <C-s> :Telescope find_files<CR>
nnoremap <C-f> :Telescope live_grep<CR>

" Open NerdTree
nnoremap <silent> <C-w>o :NERDTreeToggle<Bar>echo @%<CR>
" Open vista
let g:vista_default_executive = 'coc'
nnoremap <silent> <C-w>t :Vista!!<CR>
" vim-fugitive
nnoremap <silent> <C-w>gd :Gvdiffsplit!<CR>
nnoremap <silent> <C-w>gs :vertical Git<CR>

" clang-format
function! Formatonsave()
	let l:formatdiff = 1
	py3f /usr/share/clang/clang-format-12/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
nnoremap <leader>f :py3f /usr/share/clang/clang-format-12/clang-format.py<CR>:echo 'Formatted lines'<CR>
vnoremap <leader>f :py3f /usr/share/clang/clang-format-12/clang-format.py<CR>:echo 'Formatted lines'<CR>
" nnoremap <leader>cf :!clang-include-fixer-11<CR>

" completion-nvim
imap <C-space> <Plug>(completion_trigger)
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" TrueZen.vim
nnoremap Z :TZAtaraxis<CR>
