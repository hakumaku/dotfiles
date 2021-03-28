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

