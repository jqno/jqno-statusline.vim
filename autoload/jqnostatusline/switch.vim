function! jqnostatusline#switch#highlight(name) abort
    if a:name ==? 'simple'
        call jqno_simple#highlight()
    elseif a:name ==? 'bubble'
        call jqno_bubble#highlight()
    endif
endfunction

function! jqnostatusline#switch#statusline(name) abort
    if a:name ==? 'simple'
        return jqno_simple#statusline()
    elseif a:name ==? 'bubble'
        return jqno_bubble#statusline()
    endif
endfunction

