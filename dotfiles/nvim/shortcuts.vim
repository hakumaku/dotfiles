" Move cursor by virtual lines.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap Y y$
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Insert a newline in normal mode.
nnoremap <CR> o<ESC>k
" Move the current line one down.
" nnoremap <silent> <C-j> :m+1<Bar>echo 'Move line down'<CR>
" Move the current line one up.
" nnoremap <silent> <C-k> :m-2<Bar>echo 'Move line up'<CR>
" Jump to the next tab ')'
inoremap <C-l> <C-o>f)

" Toggle displaying whitespaces. Mapped to 'ctrl + /'
nnoremap <silent> <C-_> :set nolist!<Bar>echo 'Show whitespaces'<CR>
" Commentate
vnoremap <C-_> :call Commentate()<CR>

" Removes any search highlighting.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Insert space in normal mode
nnoremap <space> i<space><ESC>
" Copy & Paste
" If it does not work, please check if vim is compiled with clipboard
" features: vim --version | grep 'clipboard'.
" ( '+' means it supports, '-' not.)
" If you are using ubuntu or gnome environment,
" run 'sudo apt install vim-gtk3'
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
nnoremap <leader>cf :!clang-include-fixer-11<CR>

" Mappings for CoCList
" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" {{{ coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <silent><expr> <Tab>
" 	\ pumvisible() ? "\<C-n>" :
" 	\ <SID>check_back_space() ? "\<Tab>" :
" 	\ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
								\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <C-space> <Plug>(coc-fix-current)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

