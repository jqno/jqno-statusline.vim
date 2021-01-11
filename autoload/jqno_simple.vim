function! jqno_simple#highlight() abort
    call jqnostatusline#highlights#define_plain()
endfunction

function! jqno_simple#statusline() abort
    let l:pipe = g:jqnostatusline#constants#PIPE
    let l:wrapped_pipe = ' ' . l:pipe . ' '

    let l:is_active = jqnostatusline#functions#is_active()
    let l:is_not_terminal = jqnostatusline#functions#is_not_terminal()
    let l:is_active_not_terminal = jqnostatusline#functions#is_active_not_terminal()

    let l:ale_status = jqnostatusline#functions#status()
    let l:ale_ok = l:ale_status['ok']
    let l:ale_warning = l:ale_status['warning']
    let l:ale_error = l:ale_status['error']

    let l:mods = jqnostatusline#functions#wrap(jqnostatusline#functions#modifiers(l:is_not_terminal), l:wrapped_pipe, ' ')
    let l:modification = jqnostatusline#functions#wrap(jqnostatusline#functions#modification(), l:wrapped_pipe, '')

    let l:lsp_status = jqnostatusline#functions#wrap(jqnostatusline#functions#lsp_status(), '', l:wrapped_pipe)

    let l:ok = jqnostatusline#functions#wrap(l:ale_ok, '  ', ' ')
    let l:warning = jqnostatusline#functions#wrap(l:ale_warning, '  ', ' ')
    let l:error = jqnostatusline#functions#wrap(l:ale_error, '  ', ' ')

    let l:encoding = jqnostatusline#functions#wrap(jqnostatusline#functions#file_encoding(), '', l:wrapped_pipe)
    let l:format = jqnostatusline#functions#wrap(jqnostatusline#functions#file_format(), '', l:wrapped_pipe)
    let l:filetype = jqnostatusline#functions#wrap(jqnostatusline#functions#file_type(), '', l:wrapped_pipe)

    let l:statusline =
            \ '%#SLnormalmode#%{'. l:is_active .' && mode()=="n" ? "  N " . "'. l:pipe .'" : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="t" ? "  T  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="i" ? "  I  " : ""}' .
            \ '%#SLinsertmode#%{'. l:is_active .' && mode()=="r" ? "  R  " : ""}' .
            \ '%#SLvisualmode#%{'. l:is_active .' && (mode()=="v" || mode()=="") ? "  V  " : ""}' .
            \ '%*' .
            \ '%{' . l:is_active .' ? "" : "     "}' .
            \ ' ' .
            \ '%<' .
            \ '%{jqnostatusline#functions#projectname()} / %{jqnostatusline#functions#filename()}' .
            \ '%{'. l:is_active .' ? "'. l:mods .'" : ""}' .
            \ '%{'. l:is_active_not_terminal .' ? "'. l:modification .'" : ""}' .
            \ '%*' .
            \ '%=' .
            \ ' ' .
            \ '%{' . l:is_active_not_terminal . ' ? "' . l:lsp_status . '" : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? "'. l:encoding .'" : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? "'. l:format .'" : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? "'. l:filetype . '" : "" }' .
            \ '%{' . l:is_active_not_terminal . ' ? line(".") . ":" . col(".") . " [" . line("$") . "] " : "" }' .
            \ '%#SLok#%{' . l:is_active_not_terminal . ' ? "' . l:ok . '" : "" }' .
            \ '%#SLwarning#%{' . l:is_active_not_terminal . ' ? "' . l:warning . '" : "" }' .
            \ '%#SLerror#%{' . l:is_active_not_terminal . ' ? "' . l:error . '" : "" }' .
            \ '%*'

    return l:statusline
endfunction

