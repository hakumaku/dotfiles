" {{{ Vundle (https://github.com/VundleVim/Vundle.vim.git)
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	" Essential
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'scrooloose/syntastic'
	Plugin 'scrooloose/nerdtree'
	Plugin 'ryanoasis/vim-devicons'
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-surround'
	Plugin 'raimondi/delimitmate'

	" Enhanced Python
	" Plugin 'davidhalter/jedi-vim'
	Plugin 'vim-python/python-syntax'

	" Enhanced Cpp
	Plugin 'bfrg/vim-cpp-modern'
	Plugin 'majutsushi/tagbar'

	" Colorschemes
	Plugin 'lifepillar/vim-solarized8'

	" Status line
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" {{{ Vim Basic Settings
syntax on
if (has("termguicolors"))
	set termguicolors
endif

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
set listchars=tab:»\ ,eol:↲,trail:·

" Soft wrapping text
set wrap linebreak nolist
set ttyfast				" More characters will be sent to the screen
set ttimeout			" Time waited for key press to complete
set ttimeoutlen=50

set scrolloff=3			" Show 3 lines above or below cursor when scrolling
set colorcolumn=81
set showmode			" Show insert, replace, or visual mode in last line
set showcmd				" Show command in last line
set wildmenu			" On pressing 'wildchar' to invoke completion
set encoding=utf-8		" Encoding
set fileencoding=utf-8
set nobackup			" No backup files
set nowritebackup
set noswapfile

" Enable folding
set foldmethod=syntax
set nofoldenable
set foldnestmax=5
set foldlevel=5

set splitbelow			" When opening h splits, place cursor in the new split
set splitright			" When opening v splits, place cursor in the new split

set cursorline			" Show cursor line
set incsearch			" Dynamic search
set hlsearch			" Highlight search
set ignorecase			" Case insensitive search
set smartcase			" Case sensitive if contains at least one capital letter
set laststatus=2
set fillchars=fold:\ 	" Replace - with ' '
set signcolumn="yes"

" For GDB in vim
packadd termdebug
nnoremap <F2> :vert term<CR>
func! OpenTermDebug()
	if bufexists("gdb communication")
		:call TermDebugSendCommand('quit')
	else
		:Termdebug
		:wincmd h
		:wincmd L
	endif
endfunc
nnoremap <F3> :call OpenTermDebug()<CR>
let g:termdebug_wide = 1

" {{{ Common typos
iabbrev sturct struct
iabbrev wrod word
iabbrev wrods words
iabbrev teh the
iabbrev mian main
" }}}

" }}}

" {{{ Customized Shortcut
" Move cursor by virtual lines.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Insert a newline in normal mode.
nnoremap <CR> o<ESC>k
" Move the current line one down.
nnoremap <silent> <C-j> :m+1<Bar>echo 'Move line down'<CR>
" Move the current line one up.
nnoremap <silent> <C-k> :m-2<Bar>echo 'Move line up'<CR>

" Open NerdTree
nnoremap <silent> <C-s> :NERDTreeToggle<Bar>echo @%<CR>

" YCM quick fix
nnoremap <C-f> :YcmCompleter FixIt<CR>

" Toggle displaying whitespaces. Mapped to 'ctrl + /'
nnoremap <silent> <C-_> :set nolist!<Bar>echo 'Show whitespaces'<CR>
" Commentate
vnoremap <C-_> :call Commentate()<CR>

" Removes any search highlighting.
nnoremap <silent> <C-q> :nohl<Bar>echo 'Turn off highlights'<CR>
" Insert space in normal mode
nnoremap <space> i<space><esc>
" Toggle .vimrc file.
nnoremap <expr> <Home> bufname('%') == $MYVIMRC ? ':bd<CR>' : ':e $MYVIMRC<CR>'
" Replace
vnoremap <C-h> y:call Replace()<CR>
" Exact replace
vnoremap <C-g> y:call ExactReplace()<CR>
" Copy & Paste
" If it does not work, please check if vim is compiled with clipboard
" features: vim --version | grep 'clipboard'.
" ( '+' means it supports, '-' not.)
" If you are using ubuntu or gnome environment,
" run 'sudo apt install vim-gnome'
vnoremap <C-c> "+y:echo 'Yanked to clipboard'<CR>
inoremap <C-v> <ESC>"+pa

" Cycle through buffers
nnoremap <silent> <C-n> :silent bn<Bar>echo @%<CR>
nnoremap <silent> <C-p> :silent bp<Bar>echo @%<CR>
nnoremap <silent> <BS> :silent bd<Bar>echo @%<CR>

" }}}

" {{{ Vim Functions
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
	exe "iab <silent> <buffer> ".a:ab." <C-R>=MapNoContext('".
		\a:ab."', '".escape(a:full.'<C-R>=EatWhitespace()<CR>', '<>"').
		\"')<CR>"
endfunc
" }}}

let g:argv = ''
func! SetCLA()
	call inputsave()
	let l:new_args = input("Command line arguments(type \'clear\' to reset): ")
	call inputrestore()
	redraw
	if l:new_args == "clear"
		let g:argv = ''
		echo 'Cleared command line arguments.'
	else
		let g:argv = g:argv.' '.l:new_args
		echo 'Current argv: ['.g:argv.' ]'
	endif
endfunc

func! CompileRun()
	let l:cwd = getcwd()
	let l:flags = "-Wall -Wextra -Wshadow -O2 -std=c99"
	silent exe 'cd' fnameescape(expand("%:h"))
	silent exe '!gcc' shellescape(expand("%")) l:flags
	exe '!./a.out'
	silent exe 'cd' fnameescape(l:cwd)
endfunc

func! CompileDebug()
	let l:cwd = getcwd()
	let l:flags = "-Wall -Wextra -Wshadow -g2 -std=c99"
	silent exe 'cd' fnameescape(expand("%:h"))
	silent exe "!gcc" "%" l:flags
	exe "!gdb a.out"
	silent exe 'cd' fnameescape(l:cwd)
endfunc

func! CompileAssem()
	let l:flags = "-fverbose-asm -S -O2 -std=c99"
	let l:output = expand("%:r").".s"
	silent exe "!gcc" "%" l:flags "-o ".l:output
	exe "edit" l:output
endfunc
" }}}

" {{{ Autocommand
augroup project
	au!
	au BufRead,BufNewFile *.h,*.c set filetype=c
	au BufRead,BufNewFile * setlocal signcolumn=yes
augroup END

augroup file_c
	au!
	" Insert comment
	au FileType c call Iab('icom', '/*  */<esc>2<Left>i')
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
	au FileType cpp call Iab('#g', '<esc>ddggO#ifndef <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
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
	au FileType cpp call Iab('Main', 'int main(int argc, const char *argv[])<CR>
					\{<CR>}<CR><esc><Up>Oreturn 0;<esc>O<esc>O')

	" Common functions
	au FileType cpp call Iab('sout', 'std::cout << << std::endl;<esc>2gEa ')

	" if statement
	au FileType cpp call Iab('if', 'if () {<CR>}<esc>2ba')
	au FileType cpp call Iab('elif', 'else if () {<CR>}<esc>2ba')
	au FileType cpp call Iab('else', 'else {<CR>}<esc>O')
	au FileType cpp call Iab('while', 'while () {<CR>}<esc>2ba')
	au FileType cpp call Iab('fori', 'for (int i = 0; i < ; i++) {<CR>}<esc>3Bi')
	au FileType cpp call Iab('fore', 'for (const auto &item : ) {<CR>}<esc>2Bi')
	au FileType cpp call Iab('switch', 'switch () {<CR>default:<CR>break;<CR>}<esc>6ba')

	" Include Guard
	au FileType cpp call Iab('#g', '<esc>ddggO#ifndef <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
				\#define <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED<CR>
				\<esc>Go<CR>#endif /* <C-R>=expand("%:t")<CR><esc>BviwUf.Da_INCLUDED */<esc>2<C-o>')
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

augroup file_java
	au!
	au FileType java setlocal omnifunc=javacomplete#Complete
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
" {{{ vim-solarized8 (https://github.com/lifepillar/vim-solarized8)
set background=dark
" Options: solarized8_high, solarized8, solarized8_low solarized8_flat
silent! colorscheme solarized8_high
" }}}
" {{{ vim-syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_compiler_options = '-std=c99'
let g:syntastic_cpp_compiler_options = '-std=c++17'
let g:syntastic_loc_list_height=1
let g:ycm_show_diagnostics_ui = 1
let g:syntastic_python_python_exec = 'python3'
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
" {{{ vim-devicons
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 1
" }}}
" {{{ YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" Disable scratch window.
" set completeopt-=preview
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_complete_in_comments = 1
let g:ycm_open_loclist_on_ycm_diags = 0
noremap <F5> :YcmForceCompileAndDiagnostics<CR>
" }}}
" {{{ python-syntax
let g:python_highlight_all = 1
" }}}
