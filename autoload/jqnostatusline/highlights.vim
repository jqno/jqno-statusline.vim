function! jqnostatusline#highlights#define_plain() abort
    highlight link SLnormalmode StatusLine
    highlight link SLinsertmode Constant
    highlight link SLvisualmode Visual
    highlight link SLok DiffAdd
    highlight link SLwarning DiffChange
    highlight link SLerror DiffDelete
endfunction

function! jqnostatusline#highlights#define_fancy() abort
    let l:black = 'Black'
    let l:defaults = jqnostatusline#highlights#colors(l:black, l:black, l:black, l:black)
    let l:constant = jqnostatusline#highlights#get_colors_of('Constant', l:defaults)
    let l:statuslinenc = jqnostatusline#highlights#get_colors_of('StatusLineNC', l:defaults)

    let l:slnormalmode = jqnostatusline#highlights#get_colors_of('StatusLine', l:defaults)
    let l:slinsertmode = jqnostatusline#highlights#colors(l:constant['cterm-fg'], l:black, l:constant['gui-fg'], l:black)
    let l:slvisualmode = jqnostatusline#highlights#get_colors_of('Visual', l:defaults)
    let l:slok = jqnostatusline#highlights#get_colors_of('DiffAdd', l:defaults)
    let l:slwarning = jqnostatusline#highlights#get_colors_of('DiffChange', l:defaults)
    let l:slerror = jqnostatusline#highlights#get_colors_of('DiffDelete', l:defaults)

    let l:slnormalmodei = jqnostatusline#highlights#colors(l:slnormalmode['cterm-bg'], l:statuslinenc['cterm-bg'], l:slnormalmode['gui-bg'], l:statuslinenc['gui-bg'])
    let l:slinsertmodei = jqnostatusline#highlights#colors(l:slinsertmode['cterm-bg'], l:statuslinenc['cterm-bg'], l:slinsertmode['gui-bg'], l:statuslinenc['gui-bg'])
    let l:slvisualmodei = jqnostatusline#highlights#colors(l:slvisualmode['cterm-bg'], l:statuslinenc['cterm-bg'], l:slvisualmode['gui-bg'], l:statuslinenc['gui-bg'])
    let l:sloki = jqnostatusline#highlights#colors(l:slok['cterm-bg'], l:statuslinenc['cterm-bg'], l:slok['gui-bg'], l:statuslinenc['gui-bg'])
    let l:slwarningi = jqnostatusline#highlights#colors(l:slwarning['cterm-bg'], l:statuslinenc['cterm-bg'], l:slwarning['gui-bg'], l:statuslinenc['gui-bg'])
    let l:slerrori = jqnostatusline#highlights#colors(l:slerror['cterm-bg'], l:statuslinenc['cterm-bg'], l:slerror['gui-bg'], l:statuslinenc['gui-bg'])

    call jqnostatusline#highlights#define_group('SLbackground', l:statuslinenc)
    call jqnostatusline#highlights#define_group('SLnormalmode', l:slnormalmode)
    call jqnostatusline#highlights#define_group('SLinsertmode', l:slinsertmode)
    call jqnostatusline#highlights#define_group('SLvisualmode', l:slvisualmode)
    call jqnostatusline#highlights#define_group('SLok', l:slok)
    call jqnostatusline#highlights#define_group('SLwarning', l:slwarning)
    call jqnostatusline#highlights#define_group('SLerror', l:slerror)
    call jqnostatusline#highlights#define_group('SLnormalmodeI', l:slnormalmodei)
    call jqnostatusline#highlights#define_group('SLinsertmodeI', l:slinsertmodei)
    call jqnostatusline#highlights#define_group('SLvisualmodeI', l:slvisualmodei)
    call jqnostatusline#highlights#define_group('SLokI', l:sloki)
    call jqnostatusline#highlights#define_group('SLwarningI', l:slwarningi)
    call jqnostatusline#highlights#define_group('SLerrorI', l:slerrori)
endfunction

function! jqnostatusline#highlights#get_colors_of(group, defaults) abort
    let l:id = synIDtrans(hlID(a:group))
    let l:cterm_fg = synIDattr(l:id, 'fg', 'cterm')
    let l:cterm_bg = synIDattr(l:id, 'bg', 'cterm')
    let l:gui_fg = synIDattr(l:id, 'fg', 'gui')
    let l:gui_bg = synIDattr(l:id, 'bg', 'gui')
    return jqnostatusline#highlights#colors(
        \ empty(l:cterm_fg) ? a:defaults['cterm-fg'] : l:cterm_fg,
        \ empty(l:cterm_bg) ? a:defaults['cterm-bg'] : l:cterm_bg,
        \ empty(l:gui_fg) ? a:defaults['gui-fg'] : l:gui_fg,
        \ empty(l:gui_bg) ? a:defaults['gui-bg'] : l:gui_bg)
endfunction

function! jqnostatusline#highlights#colors(cterm_fg, cterm_bg, gui_fg, gui_bg) abort
    return { 'cterm-fg': a:cterm_fg, 'cterm-bg': a:cterm_bg, 'gui-fg': a:gui_fg, 'gui-bg': a:gui_bg }
endfunction

function! jqnostatusline#highlights#define_group(group, colors) abort
    exe printf('hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s',
        \ a:group,
        \ a:colors['cterm-fg'],
        \ a:colors['cterm-bg'],
        \ a:colors['gui-fg'],
        \ a:colors['gui-bg'])
endfunction

