" Vim syntax file
" Language:	A-A-P recipe
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2003 Jun 27

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match	aapSpecial '$#'
syn match	aapSpecial '$\$'
syn match	aapSpecial '$(.)'
syn keyword	aapTodo contained TODO Todo
syn match	aapString +'[^']\{-}'+
syn match	aapString +"[^"]\{-}"+

syn match	aapCommand '^\s*:action\>'
syn match	aapCommand '^\s*:add\>'
syn match	aapCommand '^\s*:addall\>'
syn match	aapCommand '^\s*:asroot\>'
syn match	aapCommand '^\s*:assertpkg\>'
syn match	aapCommand '^\s*:attr\>'
syn match	aapCommand '^\s*:attribute\>'
syn match	aapCommand '^\s*:autodepend\>'
syn match	aapCommand '^\s*:buildcheck\>'
syn match	aapCommand '^\s*:cd\>'
syn match	aapCommand '^\s*:checkin\>'
syn match	aapCommand '^\s*:checkout\>'
syn match	aapCommand '^\s*:chdir\>'
syn match	aapCommand '^\s*:child\>'
syn match	aapCommand '^\s*:chmod\>'
syn match	aapCommand '^\s*:commit\>'
syn match	aapCommand '^\s*:commitall\>'
syn match	aapCommand '^\s*:copy\>'
syn match	aapCommand '^\s*:del\>'
syn match	aapCommand '^\s*:deldir\>'
syn match	aapCommand '^\s*:delete\>'
syn match	aapCommand '^\s*:delrule\>'
syn match	aapCommand '^\s*:dll\>'
syn match	aapCommand '^\s*:do\>'
syn match	aapCommand '^\s*:error\>'
syn match	aapCommand '^\s*:execute\>'
syn match	aapCommand '^\s*:exit\>'
syn match	aapCommand '^\s*:export\>'
syn match	aapCommand '^\s*:fetch\>'
syn match	aapCommand '^\s*:fetchall\>'
syn match	aapCommand '^\s*:filetype\>'
syn match	aapCommand '^\s*:global\>'
syn match	aapCommand '^\s*:include\>'
syn match	aapCommand '^\s*:lib\>'
syn match	aapCommand '^\s*:local\>'
syn match	aapCommand '^\s*:mkdir\>'
syn match	aapCommand '^\s*:mkdownload\>'
syn match	aapCommand '^\s*:move\>'
syn match	aapCommand '^\s*:pass\>'
syn match	aapCommand '^\s*:popdir\>'
syn match	aapCommand '^\s*:program\>'
syn match	aapCommand '^\s*:progsearch\>'
syn match	aapCommand '^\s*:publish\>'
syn match	aapCommand '^\s*:publishall\>'
syn match	aapCommand '^\s*:pushdir\>'
syn match	aapCommand '^\s*:quit\>'
syn match	aapCommand '^\s*:recipe\>'
syn match	aapCommand '^\s*:refresh\>'
syn match	aapCommand '^\s*:remove\>'
syn match	aapCommand '^\s*:removeall\>'
syn match	aapCommand '^\s*:require\>'
syn match	aapCommand '^\s*:revise\>'
syn match	aapCommand '^\s*:reviseall\>'
syn match	aapCommand '^\s*:route\>'
syn match	aapCommand '^\s*:rule\>'
syn match	aapCommand '^\s*:start\>'
syn match	aapCommand '^\s*:symlink\>'
syn match	aapCommand '^\s*:sys\>'
syn match	aapCommand '^\s*:syspath\>'
syn match	aapCommand '^\s*:system\>'
syn match	aapCommand '^\s*:tag\>'
syn match	aapCommand '^\s*:tagall\>'
syn match	aapCommand '^\s*:touch\>'
syn match	aapCommand '^\s*:tree\>'
syn match	aapCommand '^\s*:unlock\>'
syn match	aapCommand '^\s*:update\>'
syn match	aapCommand '^\s*:usetool\>'
syn match	aapCommand '^\s*:variant\>'
syn match	aapCommand '^\s*:verscont\>'

syn match	aapCommand '^\s*:print\>' nextgroup=aapPipeEnd
syn match	aapPipeCmd '\s*:print\>' nextgroup=aapPipeEnd contained
syn match	aapCommand '^\s*:cat\>' nextgroup=aapPipeEnd
syn match	aapPipeCmd '\s*:cat\>' nextgroup=aapPipeEnd contained
syn match	aapCommand '^\s*:syseval\>' nextgroup=aapPipeEnd
syn match	aapPipeCmd '\s*:syseval\>' nextgroup=aapPipeEnd contained
syn match	aapPipeCmd '\s*:assign\>' contained
syn match	aapCommand '^\s*:eval\>' nextgroup=aapPipeEnd
syn match	aapPipeCmd '\s*:eval\>' nextgroup=aapPipeEnd contained
syn match	aapPipeCmd '\s*:tee\>' nextgroup=aapPipeEnd contained
syn match	aapPipeEnd '[^|]*|' nextgroup=aapPipeCmd contained

syn include @aapPythonScript syntax/python.vim
"
" A Python line starts with @.  Can be continued with a trailing backslash.
syn region aapPythonRegion start="\s*@" skip='\\$' end=+$+ contains=@aapPythonScript keepend
"
" A Python block starts with ":python" and continues so long as the indent is
" bigger.
syn region aapPythonRegion matchgroup=aapCommand start="\z(\s*\):python" skip='\n\z1\s\|\n\s*\n' end=+$+ contains=@aapPythonScript

" A Python expression is enclosed in backticks.
syn region aapPythonRegion start="`" skip="``" end="`" contains=@aapPythonScript

" TODO: There is something wrong with line continuation.
syn match	aapComment '#.*' contains=aapTodo
syn match	aapComment '#.*\(\\\n.*\)' contains=aapTodo

" A heredoc assignment.
syn region aapHeredoc start="^\s*\k\+\s*$\=+\=?\=<<\s*\z(\S*\)"hs=e+1 end="^\s*\z1\s*$"he=s-1

" Syncing is needed for ":python" and "VAR << EOF".  Don't use Python syncing
syn sync clear
syn sync fromstart

" The default highlighting.
hi def link aapTodo		Todo
hi def link aapString		String
hi def link aapComment		Comment
hi def link aapSpecial		Special
hi def link aapPipeCmd		aapCommand
hi def link aapCommand		Statement
hi def link aapHeredoc		Constant

let b:current_syntax = "aap"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
