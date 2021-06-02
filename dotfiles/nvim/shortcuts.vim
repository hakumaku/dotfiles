" Move cursor by virtual lines.
" nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
" nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap Y y$
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

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

" Removes any search highlighting.
nnoremap <silent> <C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Insert space in normal mode
nnoremap <space> i<space><ESC>
" Copy & Paste
vnoremap <C-c> "+y:echo 'Yanked to clipboard'<CR>
inoremap <C-v> <ESC>"+pa

" Escape terminal mode
let g:termdebug_useFloatingHover = 0
let g:termdebug_use_prompt = 1
tnoremap <Esc> <C-\><C-n>
nnoremap <RightMouse> :Break<CR>

" Reverse selected lines.
vnoremap <silent> <leader>r y:lua utils.reverse_lines()<CR>
" Jump to the next tab ')'
inoremap <silent> <C-l> <esc>:lua utils.jump_right()<CR>a
" External Utilities
nnoremap <leader>1 :.!toilet -w 200 -f term -F border<CR>

" Cycle through buffers
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> [b :bp<CR>
nnoremap <silent> <BS> :silent bd<Bar>echo @%<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> [g :lnext<CR>
nnoremap <silent> ]g :lprev<CR>
nnoremap <silent> ]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [d :lua vim.lsp.diagnostic.goto_prev()<CR>

" LSP config
nnoremap <silent> <C-]>     :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-Space> :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>s :ClangdSwitchSourceHeader<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>c :lua vim.lsp.buf.rename()<CR>

" neoformat
nnoremap <leader>f :Neoformat<CR>

" Telescope
nnoremap <C-s>f :Telescope find_files<CR>
nnoremap <C-s>s :Telescope live_grep<CR>
nnoremap <C-s>b :Telescope buffers<CR>
nnoremap <C-s>/ :Telescope current_buffer_fuzzy_find<CR>

" NerdTree
" nnoremap <silent> <C-w>o :NERDTreeToggle<Bar>echo @%<CR>
" NvimTree
nnoremap <silent> <C-w>o :NvimTreeToggle<CR>

" Vista
nnoremap <silent> <C-w>t :Vista!!<CR>

" trouble.nvim
nnoremap <silent> <C-w>T :TroubleToggle<CR>

" vim-fugitive
nnoremap <silent> gd :Gvdiffsplit!<CR>
nnoremap <silent> gs :vertical Git<CR>
nnoremap <silent> gb :Gitsigns toggle_current_line_blame<CR>

" nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
