" Vim syntax file for TODO lists
" Author: Krzysztof Arendt
" Date: 23 June 2021

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword _TaskKeys TASK
syn keyword _TodoKeys TODO
syn keyword _DoneKeys DONE
syn keyword _NoteKeys NOTE

" Matches
syn match _CommentMatch "//.*$"
syn match _TitleMatch "#.*$"

" Regions
syn region _CustomReg start="/\*" end="\*/" contains=_CommentMatch

" Highlighting rules
hi def link _TaskKeys    Statement
hi def link _TodoKeys    DiffDelete
hi def link _DoneKeys    DiffAdd
hi def link _NoteKeys    Type
hi def link _CommentMatch Comment
hi def link _TitleMatch  Constant
hi def link _CustomReg   Comment
