function! jqnostatusline#highlights#define_plain() abort
    highlight link SLnormalmode StatusLine
    highlight link SLinsertmode Constant
    highlight link SLvisualmode Visual
    highlight link SLok DiffAdd
    highlight link SLerror DiffDelete
    highlight link SLwarning DiffChange
endfunction

function! jqnostatusline#highlights#define_fancy() abort
    highlight link SLnormalmode WildMenu
    highlight link SLvisualmode Visual
    highlight link SLok DiffAdd
    highlight link SLerror DiffDelete
    highlight link SLwarning DiffChange

    let l:slid = synIDtrans(hlID('StatusLine'))
    let l:ncid = synIDtrans(hlID('StatusLineNC'))
    let l:ctermfg = synIDattr(l:slid, 'fg#', 'cterm')
    let l:ctermbg = synIDattr(l:ncid, 'bg#', 'cterm')
    let l:guifg = synIDattr(l:slid, 'fg#', 'gui')
    let l:guibg = synIDattr(l:ncid, 'bg#', 'gui')
    exe printf('hi! StatusLine ctermfg=White ctermbg=%s guifg=White guibg=%s', l:ctermbg, l:guibg)

    let l:id = synIDtrans(hlID('Constant'))
    let l:ctermfg = synIDattr(l:id, 'fg#', 'cterm')
    let l:guifg = synIDattr(l:id, 'fg#', 'gui')
    exe printf('hi SLinsertmode ctermfg=%s ctermbg=Black guifg=%s guibg=Black', l:ctermfg, l:guifg)

    call jqnostatusline#highlights#define_inverted()
endfunction

function! jqnostatusline#highlights#define_inverted() abort
    call jqnostatusline#highlights#define_inverted_highlight('SLnormalmode')
    call jqnostatusline#highlights#define_inverted_highlight('SLinsertmode')
    call jqnostatusline#highlights#define_inverted_highlight('SLvisualmode')
    call jqnostatusline#highlights#define_inverted_highlight('SLok')
    call jqnostatusline#highlights#define_inverted_highlight('SLerror')
    call jqnostatusline#highlights#define_inverted_highlight('SLwarning')
endfunction

function! jqnostatusline#highlights#define_inverted_highlight(group) abort
    let l:fgId = synIDtrans(hlID(a:group))
    let l:bgId = synIDtrans(hlID('StatusLineNC'))
    let l:ctermfg = synIDattr(l:fgId, 'bg#', 'cterm')
    let l:ctermfg = empty(l:ctermfg) ? 'Black': l:ctermfg
    let l:ctermbg = synIDattr(l:bgId, 'bg#', 'cterm')
    let l:ctermbg = empty(l:ctermbg) ? '#000000': l:ctermbg
    let l:guifg = synIDattr(l:fgId, 'bg#', 'gui')
    let l:guifg = empty(l:guifg) ? 'Black': l:guifg
    let l:guibg = synIDattr(l:bgId, 'bg#', 'gui')
    let l:guibg = empty(l:guibg) ? '#000000': l:guibg
    let l:grp = a:group . 'I'
    exe printf('hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s', l:grp, l:ctermfg, l:ctermbg, l:guifg, l:guibg)
endfunction

