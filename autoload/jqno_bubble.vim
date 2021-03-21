function! jqno_bubble#bubble(b, text, group, is_a_fn = v:false) abort
    let l:result = ''
    if !empty(a:text)
        let l:result .= '%#' . a:group . 'I#%{' . a:b . ' ? "  ' . g:jqnostatusline#constants#OPEN . '" : ""}'
        let l:result .= jqno_bubble#print_in_bubble(a:b, '', a:text, '', a:group, a:is_a_fn)
        let l:result .= '%#' . a:group . 'I#%{' . a:b . ' ? "' . g:jqnostatusline#constants#CLOSE . '" : ""}'
    endif
    return l:result
endfunction

function! jqno_bubble#double_bubble(b, text1, group1, text2, group2, is_a_fn = v:false) abort
    let l:result = ''
    let l:result .= '%#' . a:group1 . 'I#%{' . a:b . ' ? "  ' . g:jqnostatusline#constants#OPEN . '" : ""}'
    let l:result .= jqno_bubble#print_in_bubble(a:b, '', a:text1, ' ', a:group1, a:is_a_fn)
    let l:result .= jqno_bubble#print_in_bubble(a:b, '  ', a:text2, '', a:group2, a:is_a_fn)
    let l:result .= '%#' . a:group2 . 'I#%{' . a:b . ' ? "' . g:jqnostatusline#constants#CLOSE . '" : ""}'
    return l:result
endfunction

function! jqno_bubble#print_in_bubble(b, pre, text, post, group, is_a_fn) abort
    if a:is_a_fn
        return '%#' . a:group . '#%{' . a:b . ' ? "' . a:pre . '" . ' . a:text . ' . "' . a:post . '" : ""}'
    else
        return '%#' . a:group . '#%{' . a:b . ' ? "' . a:pre . a:text . a:post . '" : ""}'
    endif
endfunction

function! jqno_bubble#highlight() abort
    call jqnostatusline#highlights#define_fancy()
endfunction

function! jqno_bubble#statusline() abort
    let l:is_active = jqnostatusline#functions#is_active()
    let l:is_not_active = jqnostatusline#functions#is_not_active()
    let l:is_not_terminal = jqnostatusline#functions#is_not_terminal()
    let l:is_active_not_terminal = jqnostatusline#functions#is_active_not_terminal()

    let l:modifiers = jqnostatusline#functions#modifiers(l:is_not_terminal)

    let l:ale_status = jqnostatusline#functions#status()
    let l:ale_ok = l:ale_status['ok']
    let l:ale_warning = l:ale_status['warning']
    let l:ale_error = l:ale_status['error']

    let l:lsp_status = jqnostatusline#functions#lsp_status()

    let l:statusline = ''
    let l:statusline .= jqno_bubble#bubble(l:is_active . ' && mode() == "n"', 'N', 'SLnormalmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active . ' && mode() == "t"', 'T', 'SLinsertmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active . ' && mode() == "i"', 'I', 'SLinsertmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active . ' && mode() == "r"', 'R', 'SLinsertmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active . ' && mode() == "v" || mode() == ""', 'V', 'SLvisualmode')
    let l:statusline .= jqno_bubble#double_bubble(l:is_active, 'jqnostatusline#functions#filename()', 'SLnormalmode', 'jqnostatusline#functions#projectname()', 'SLvisualmode', v:true)
    let l:statusline .= '%#SLbackground#%{' . l:is_not_active . ' ? "       " . jqnostatusline#functions#filename() : ""}'
    let l:statusline .= '%<'
    let l:statusline .= jqno_bubble#bubble(l:is_active, l:modifiers, 'SLnormalmode')
    let l:statusline .= '%='
    if &filetype ==# 'markdown'
        let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, jqnostatusline#functions#wordcount() . ' words', 'SLvisualmode')
    endif
    let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, l:lsp_status, 'SLvisualmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, jqnostatusline#functions#metadata(), 'SLnormalmode')
    let l:statusline .= jqno_bubble#double_bubble(l:is_active_not_terminal, line('.') . ':' . col('.'), 'SLnormalmode', line('$') . ':' . (col('$')-1), 'SLvisualmode')
    let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, l:ale_ok, 'SLok')
    if empty(l:ale_warning) || empty(l:ale_error)
        let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, l:ale_warning, 'SLwarning')
        let l:statusline .= jqno_bubble#bubble(l:is_active_not_terminal, l:ale_error, 'SLerror')
    else
        let l:statusline .= jqno_bubble#double_bubble(l:is_active_not_terminal, l:ale_warning, 'SLwarning', l:ale_error, 'SLerror')
    endif
    let l:statusline .= ' '

    return l:statusline
endfunction

