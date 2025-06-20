" Vim syntax file for TODO lists
" Author: Krzysztof Arendt
" Date: 24 June 2021

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword _TaskKeys TASK
syn keyword _TodoKeys TODO
syn keyword _DoneKeys DONE
syn keyword _WorkKeys WORK
syn keyword _NoteKeys NOTE

" Matches
syn match _CommentMatch "//.*$"
syn match _TitleMatch "#.*$"

" Regions
syn region _MultiCommentReg start="/\*" end="\*/"
syn region _MultiCommentReg start="\~\~" end="\~\~"
syn region _EmphasizeReg start="\*\*" end="\*\*"

" Highlighting rules
hi def link _TaskKeys           Statement
hi def link _TodoKeys           DiffDelete
hi def link _DoneKeys           DiffAdd
hi def link _WorkKeys           Statement
hi def link _NoteKeys           Type
hi def link _CommentMatch       Comment
hi def link _TitleMatch         Constant
hi def link _MultiCommentReg    Comment
hi def link _EmphasizeReg       Type
