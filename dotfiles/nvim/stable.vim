" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')
	" Startify
	Plug 'mhinz/vim-startify'
	Plug 'scrooloose/nerdtree'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'

	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Cpp Development
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }
	Plug 'liuchengxu/vista.vim'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'raimondi/delimitmate'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'jackguo380/vim-lsp-cxx-highlight'

	" Colorschemes
	Plug 'lifepillar/vim-solarized8'
	Plug 'morhetz/gruvbox'

	" Status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
" Initialize plugin system
call plug#end()

" {{{ Vim Basic Settings
" {{{ For gvim
set guioptions-=m		"remove menu bar
set guioptions-=T		"remove toolbar
set guioptions-=r		"remove right-hand scroll bar
set guioptions-=L		"remove left-hand scroll bar
if has("gui_running")
	if has("gui_gtk3") || has("gui_gtk2")
		" set guifont=SauceCodePro\ Nerd\ Font\ 16
		set guifont=UbuntuMono\ Nerd\ Font\ Bold\ 16
	elseif has("gui_win32")
		set guifont=UbuntuMono\ NF\ Bold:h16
	end
endif
" }}}

syntax on
if (has("termguicolors"))
	set termguicolors
endif

" set spell
set hidden				" Hide buffers when abandoned
set number				" Show line number
set relativenumber		" Relative numbers instead of absolute
set tabstop=4			" Tab size = 4
set shiftwidth=4		" Size of the indent
set softtabstop=0		" Insert a combination of spaces when set to non-zero
set noexpandtab			" No spaces when tab
set mouse=a				" Enable mouse scrolling
set autoindent
set autoread
set listchars=tab:»\ ,eol:↲,trail:·
set backspace=indent,eol,start
" Soft wrapping text
" set wrap linebreak nolist
set ttyfast				" More characters will be sent to the screen
set ttimeout			" Time waited for key press to complete
set ttimeoutlen=50
set updatetime=300
set shortmess+=c
set scrolloff=3			" Show 3 lines above or below cursor when scrolling
set colorcolumn=101
set showmode			" Show insert, replace, or visual mode in last line
set showcmd				" Show command in last line
set wildmenu			" On pressing 'wildchar' to invoke completion
set encoding=utf-8		" Encoding
set fileencoding=utf-8
set nobackup			" No backup files
set cmdheight=2
set nowritebackup
set noswapfile
set history=1000
set tabpagemax=50
" Enable folding
set foldmethod=syntax
set nofoldenable
set foldnestmax=5
set foldlevel=5
set splitbelow			" When opening h splits, place cursor in the new split
set splitright			" When opening v splits, place cursor in the new split
" set cursorline		" Show cursor line
set incsearch			" Dynamic search
set hlsearch			" Highlight search
set ignorecase			" Case insensitive search
set smartcase			" Case sensitive if contains at least one capital letter
set smarttab
set nrformats-=octal
set sessionoptions-=options
set viewoptions-=options
set laststatus=2
set fillchars=fold:\	" Replace - with ' '
set ruler
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif
nmap <silent> [g :lnext<CR>
nmap <silent> ]g :lprev<CR>

set lazyredraw			" Do not redraw screen in the middle of a macro
if !has('nvim')
	set noesckeys		" <ESC> delay
endif

" {{{ Common typos
iabbrev sturct struct
iabbrev wrod word
iabbrev wrods words
iabbrev teh the
iabbrev mian main
iabbrev lenght length
" }}}

" }}}

" {{{ Customized Shortcut
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
" Replace
vnoremap <C-h> y:call Replace()<CR>
" Exact replace
vnoremap <C-g> y:call ExactReplace()<CR>
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
nnoremap <C-s> :FZF<CR>
" Open NerdTree
nnoremap <silent> <C-w>o :NERDTreeToggle<Bar>echo @%<CR>
" Open Tagbar
" nnoremap <silent> <C-w>t :TagbarToggle<CR>
let g:vista_default_executive = 'coc'
nnoremap <silent> <C-w>t :Vista!!<CR>
" vim-fugitive
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap <leader>gs :vertical Gstatus<CR>
" clang-format
function! Formatonsave()
	let l:formatdiff = 1
	py3f /usr/share/clang/clang-format-11/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
nnoremap <leader>f :py3f /usr/share/clang/clang-format-11/clang-format.py<CR>:echo 'Formatted lines'<CR>
vnoremap <leader>f :py3f /usr/share/clang/clang-format-11/clang-format.py<CR>:echo 'Formatted lines'<CR>
" }}}

" {{{ Vim Functions
func ReverseLines()
	let l:start = line("'<")
	let l:end = line("'>")
	let l:lines = getline(start, end)
	let l:lines = reverse(lines)
	call setline(start, lines)
endfunc

func! Commentate() range
	let l:line = getline("'<")
	let l:indent = matchstr(l:line, '^\s*')
	let l:bool = matchstr(l:line, '\S')

	if &ft == 'vim'
		let l:char = '" '
		if l:bool == '"'
			call CommentStrip(l:char, line("'<"), line("'>"))
		else
			call CommentWrite('" ', l:indent)
		endif

	elseif &ft == 'python' || &ft == 'bash'
		let l:char = '# '
		if l:bool == '#'
			call CommentStrip(l:char, line("'<"), line("'>"))
		else
			call CommentWrite(l:char, l:indent)
		endif

	elseif &ft == 'c' || &ft == 'cpp'
		let l:char = " \\* "
		if l:bool == '*' || l:bool == '/'
			let l:s = search("\\/\\*", 'ncb', line('^'))
			let l:e = search("\\*\\/", 'nc', line('$'))
			call CommentStrip(l:char, l:s+1, l:e-1)
			exe l:s."delete"
			exe l:e-1."delete"
		else
			let l:s = line("'<")
			let l:e = line("'>")
			call CommentWrite(l:char, l:indent)
			call append(l:s-1, l:indent.'/*')
			call append(l:e+1, l:indent.' */')
		endif
	endif
endfunc

func CommentWrite(char, indent)
	if empty(a:indent)
		silent! exe "'<,'>s/^/&".a:char."/"
	else
		" If the selection contains blank lines,
		" insert tabs into them.
		silent! exe "'<,'>s/^$/".a:indent."/"
		silent! exe "'<,'>s/\\s\\{,".len(a:indent)."}/&".a:char."/"
	endif
endfunc

func CommentStrip(char, start, end)
	silent! exe a:start.",".a:end."s/^\\s*".a:char."$//"
	silent! exe a:start.",".a:end."s/".a:char."//"
endfunc

func EatChar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc

func Replace()
	call inputsave()
	let word = input('Replace with: ')
	call inputrestore()
	execute '%s/'.@".'/'.word.'/gc'
endfunc

func ExactReplace()
	call inputsave()
	let word = input('Replace with: ')
	call inputrestore()
	execute '%s/\<'.@".'\>/'.word.'/gc'
endfunc

" {{{ Iab
func! EatWhitespace()
	let c = nr2char(getchar())
	return (c =~ '\s') ? '' : c
endfunc

func! MapNoContext(key, seq)
	let syn = synIDattr(synID(line('.'), col('.')-1, 1), 'name')
	if syn =~? 'comment\|string\|character\|doxygen'
		return a:key
	else
		exe 'return "'.
					\substitute(a:seq, '\\<\(.\{-}\)\\>', '"."\\<\1>"."', 'g').
			\'"'
	endif
endfunc

func! Iab(ab, full)
	let single_quote_escaped_full = substitute(a:full, "'", "''", "g")
	exe "iab <silent> <buffer> ".a:ab." <C-R>=MapNoContext('".
		\a:ab."', '".escape(single_quote_escaped_full.'<C-R>=EatWhitespace()<CR>', '<>\"').
		\"')<CR>"
endfunc
" }}}

" {{{ Autocommand
augroup project
	au!
	au BufRead,BufNewFile *.h,*.c set filetype=cpp
	au BufRead,BufNewFile * setlocal signcolumn=yes
augroup END

augroup file_c
	au!
	" Insert comment
	au FileType c call Iab('icom', '/*	*/<esc>2<Left>i')
	au FileType c call Iab('com', '/*<CR> <CR>/<Up>')
	" Insert #include
	au FileType c call Iab('incg', '#include <.h><esc>2ba')
	au FileType c call Iab('incl', '#include ".h"<esc>2ba')
	" Insert C main function
	au FileType c call Iab('Main', 'int main(int argc, const char *argv[])<CR>
					\{<CR>}<CR><esc><Up>Oreturn 0;<esc>O<esc>O')
	" if statement
	au FileType c call Iab('if', 'if () {<CR>}<esc>2ba')
	au FileType c call Iab('elif', 'else if () {<CR>}<esc>2ba')
	au FileType c call Iab('else', 'else {<CR>}<esc>O')
	au FileType c call Iab('while', 'while () {<CR>}<esc>2ba')
	au FileType c call Iab('fori', 'for (int i = 0; i < ; i++) {<CR>}<esc>3Bi')
	au FileType c call Iab('switch', 'switch () {<CR>default:<CR>break;<CR>}<esc>6ba')

	" Include Guard
	au FileType c call Iab('#g', '<esc>ddggO#ifndef <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
				\#define <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
				\<esc>Go<CR>#endif /* <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED */<esc>2<C-o>')

	" Compile and Run C file
	" au FileType c noremap <F2> :call CompileAssem()<CR>
	au FileType c noremap <C-e> :call CompileRun()<CR>
	" au FileType c noremap <F3> :call CompileDebug()<CR>
augroup END

augroup file_cc
	au!
	" Insert comment
	au FileType cpp call Iab('icom', '/*  */<esc>2<Left>i')
	au FileType cpp call Iab('com', '/*<CR> <CR>/<Up>')
	" Insert #include
	au FileType cpp call Iab('incg', '#include <><esc>ba')
	au FileType cpp call Iab('incl', '#include ".h"<esc>2ba')
	" Insert C main function
	" au FileType cpp call Iab('Main', 'int main(int argc, const char *argv[])<CR>
	" 				\{<CR>}<CR><esc><Up>Oreturn 0;<esc>O<esc>O')

	" Common functions
	" au FileType cpp call Iab('sout', 'std::cout << << ''\n'';<esc>2gEa ')
	" au FileType cpp call Iab('std', 'std::')

	" Include Guard
	" au FileType cpp call Iab('#g', '<esc>ddggO#ifndef <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
	" 			\#define <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
	" 			\<esc>Go<CR>#endif /* <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED */<esc>2<C-o>')
	au FileType cpp setlocal shiftwidth=2 softtabstop=2 tabstop=2
augroup END

augroup file_py
	au!
	au FileType python call Iab('from', 'from  import <esc>b<Left>i')
	au FileType python call Iab('if', 'if :<Left>')
	au FileType python call Iab('elif', 'elif :<Left>')
	au FileType python call Iab('else', 'else:<CR>')
	au FileType python call Iab('while', 'while :<Left>')
	au FileType python call Iab('for', 'for  in :<esc>B<Left>i')
	au FileType python call Iab('def', 'def ():<CR>pass<esc>2Bi')
	au FileType python call Iab('class', 'class ():<CR>def __init__(self, *args, **kwargs):<CR>pass<esc>4Bi')
	au FileType python call Iab('try', 'try:<CR>pass<CR><CR>except :<CR>pass<esc>2bi')
	au FileType python call Iab('pdb', 'import pdb; pdb.set_trace()')
	" au FileType python call Iab('Main', 'if __name__ == ''__main__'':<CR>main()<CR>')

	" Execute python file
	au FileType python noremap <buffer> <C-e> :exec '!python3' shellescape(@%, 1) g:argv<CR>
augroup END

augroup file_bash
	au!
	" Execute bash file
	au FileType sh noremap <buffer> <C-e> :exec '!bash' shellescape(@%, 1)<CR>
augroup END

augroup color_theme
	au!
	" Set the color of them to that of LineNr
	au ColorScheme * hi! def link SignColumn LineNr
	au ColorScheme * hi! def link Error LineNr
	au Colorscheme * hi! def link Folded Normal
	" Whitespaces
	" au ColorScheme * hi! def link SpecialKey Normal
augroup END

augroup file_vim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal foldmarker={{{,}}}
augroup END
" }}}

" {{{ Tmux
" Tmux true color settings.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" }}}
" {{{ Termdebug
let g:termdebug_wide=1
" }}}
" {{{ vim-solarized8 (https://github.com/lifepillar/vim-solarized8)
" Options: solarized8_high, solarized8, solarized8_low solarized8_flat
set background=dark
silent! colorscheme solarized8
" }}}
" {{{ gruvbox (https://github.com/morhetz/gruvbox)
" set background=dark
" let g:gruvbox_contrast = 'hard'
" silent! colorscheme gruvbox
" }}}
" {{{ vim-airline & vim-airline-themes
let g:airline#extensions#tabline#enabled = 1			" turn on buffer list
let g:airline#extensions#tabline#show_tab_nr = 1		" Show tab number
let g:airline#extensions#tabline#tab_nr_type = 1		" Show tab number
let g:airline#extensions#tabline#fnamemod = ':t'		" Display only file name
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1	" Show buffer number
let g:airline_section_b = '%{strftime("%H:%M:%S")}'
let g:airline_section_y = '%{&fenc} %{WebDevIconsGetFileFormatSymbol()}'
let g:airline_powerline_fonts = 1
" let g:airline_theme='light'
let g:airline_solarized_bg='dark'
" }}}
" {{{ NERDTree
let g:NERDTreeGlyphReadOnly = "RO"
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
	\ quit | endif
" }}}
" {{{ vim-devicons
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 1
" }}}
" {{{ FZF
" let g:fzf_layout = { 'down': '40%', 'window': '10new' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
" }}}

" {{{ coc
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
								\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <C-space> <Plug>(coc-fix-current)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" }}}
