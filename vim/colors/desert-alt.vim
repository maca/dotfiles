" Vim color file desert-alt
" generated by VimTax http://www.vimtax.com

" set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256
let colors_name = "desert-alt"


hi LineNr	        ctermfg=240    ctermbg=235 cterm=none
hi StatusLine	    ctermfg=240    ctermbg=235 cterm=none
au InsertEnter * hi LineNr ctermfg=cyan
au InsertEnter * hi StatusLine ctermfg=cyan
au InsertLeave * hi LineNr ctermfg=240
au InsertLeave * hi StatusLine ctermfg=240

hi Comment	    ctermfg=240
hi Constant	    ctermfg=216    gui=none    cterm=none 
hi Cursor	    ctermbg=255     ctermfg=242    gui=none    cterm=none 
hi CursorLine	    guifg=#ffffff    ctermfg=231    guibg=#404040    ctermbg=237    gui=none    cterm=none 
hi ColorColumn	    guifg=#ffffff    ctermfg=231    guibg=#cc4040    ctermbg=252    gui=none    cterm=none 
hi Directory	    guifg=#008b8b    ctermfg=22    gui=none    cterm=none 
hi Folded	    guibg=#555555    ctermbg=239    guifg=#ffd700    ctermfg=220    gui=none    cterm=none 
hi Function	    guifg=#ccffcc    ctermfg=252    gui=none    cterm=none 
hi Identifier	    guifg=#ccffcc    ctermfg=214    gui=none    cterm=none 
hi MatchParen	    guifg=#ccffcc    ctermfg=252    guibg=#008b8b    ctermbg=33    gui=none    cterm=none 
hi Normal	    guifg=#fae5d7    ctermfg=NONE    guibg=#1f1002    gui=none    cterm=none " ctermbg=234    
hi NonText	    guibg=#444444    ctermbg=NONE    guifg=#81bed6    ctermfg=89    gui=none    cterm=none 
hi Number	    guifg=#ffa0a0    ctermfg=214    gui=none    cterm=none 
hi PreProc	    guifg=#ffa0a0    ctermfg=214    gui=none    cterm=none 
hi Statement	    guifg=#f0e68c    ctermfg=255    gui=none    cterm=none 
hi Special	    guifg=#fffefc    ctermfg=226    gui=none    cterm=none 
hi SpecialKey	    guifg=#9acd32    ctermfg=247    gui=none    cterm=none 
hi String	    guifg=#ffa0a0    ctermfg=64    gui=none    cterm=none 
hi StorageClass	    guifg=#bdb76b    ctermfg=250    gui=none    cterm=none 
hi Title	    guifg=#cd5c5c    ctermfg=252    gui=bold    cterm=bold 
hi Todo	       ctermfg=0 ctermbg=1    gui=none    cterm=none 
hi Type	    guifg=#bdb76b    ctermfg=250    gui=none    cterm=none 
hi Underlined	    guifg=#80a0ff    ctermfg=89    gui=underline    cterm=underline 
hi Visual	    guifg=#f0e68c    ctermfg=255    guibg=#6b8e23    ctermbg=242    gui=none    cterm=none 
hi Keyword ctermfg=214
hi Search ctermbg=black ctermfg=245


" Special for Ruby
hi rubyRegexp ctermfg=darkgreen
hi rubyRegexpDelimiter ctermfg=darkgreen 
hi rubyEscape ctermfg=cyan 
hi rubyInterpolationDelimiter ctermfg=darkgreen
hi rubyControl ctermfg=217
hi rubyInterpolation ctermfg=darkgreen
hi rubyConditional ctermfg=205
hi rubyStringDelimiter ctermfg=green 
hi link rubySymbol Identifier
hi link rubyBlockParameterList rubyControl
hi link rubyClass Keyword 
hi link rubyModule Keyword 
hi link rubyKeyword Keyword 
hi link rubyOperator Operator
hi link rubyIdentifier Identifier
hi link rubyInstanceVariable Identifier
hi link rubyGlobalVariable Identifier
hi link rubyClassVariable Identifier
hi link rubyConstant Type 

" Special for Java
hi link javaScopeDecl Identifier 
hi link javaCommentTitle javaDocSeeTag 
hi link javaDocTags javaDocSeeTag 
hi link javaDocParam javaDocSeeTag 
hi link javaDocSeeTagParam javaDocSeeTag 

hi javaDocSeeTag guifg=#CCCCCC ctermfg=darkgray 
hi javaDocSeeTag guifg=#CCCCCC ctermfg=darkgray 

" Special for XML
hi link xmlTag Keyword 
hi link xmlTagName Conditional 
hi link xmlEndTag Identifier 

" Special for HTML
hi link htmlTag Keyword 
hi link htmlTagName Conditional 
hi link htmlEndTag Identifier 

" Special for Javascript
hi link javaScriptNumber Number 

" Special for CSharp
hi link csXmlTag Keyword 

" Special for diff
highlight DiffAdd ctermbg=8 guibg=2
highlight DiffDelete ctermbg=88 guibg=88
highlight DiffChange ctermbg=235 guibg=235
highlight DiffText ctermbg=18 guibg=18

