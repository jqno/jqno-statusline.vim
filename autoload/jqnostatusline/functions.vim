function! jqnostatusline#functions#is_active() abort
    return '('. win_getid() .' == win_getid())'
endfunction

function! jqnostatusline#functions#is_not_active() abort
    return '('. win_getid() .' != win_getid())'
endfunction

function! jqnostatusline#functions#is_not_terminal() abort
    return 'term_getstatus(bufnr("%")) == ""'
endfunction

function! jqnostatusline#functions#is_active_not_terminal() abort
    return jqnostatusline#functions#is_active() . ' && ' . jqnostatusline#functions#is_not_terminal()
endfunction

function! jqnostatusline#functions#wrap(s, prefix, suffix) abort
    if len(a:s) == 0
        return a:s
    else
        return a:prefix . a:s . a:suffix
    endif
endfunction

function! jqnostatusline#functions#projectname() abort
    let l:tab = tabpagenr()
    let l:buflist = tabpagebuflist(l:tab)
    let l:winnr = tabpagewinnr(l:tab)
    let l:cwd = getcwd(l:winnr)
    let l:projectname = fnamemodify(l:cwd, ':t')
    let l:result = empty(l:projectname) ? g:jqnostatusline#constants#EMPTY : l:projectname
    return l:result
endfunction

function! jqnostatusline#functions#filename() abort
    let l:tab = tabpagenr()
    let l:buflist = tabpagebuflist(l:tab)
    let l:winnr = tabpagewinnr(l:tab)
    let l:filename = expand('#' . l:buflist[l:winnr - 1] . ':t')
    let l:result = empty(l:filename) ? g:jqnostatusline#constants#EMPTY : l:filename
    return l:result
endfunction

function! jqnostatusline#functions#modifiers(is_not_terminal) abort
    let l:result = ''
    let l:result .= &readonly ? 'RO' : ''
    let l:result .= &readonly && &previewwindow ? g:jqnostatusline#constants#PIPE : ''
    let l:result .= &previewwindow ? 'P' : ''
    return l:result
endfunction

function! jqnostatusline#functions#modification() abort
    let l:result = ''
    let l:result .= &modifiable ? '' : '-'
    let l:result .= &modified ? '+' : ''
    return l:result
endfunction

function! jqnostatusline#functions#file_encoding() abort
    let l:fileencoding = &fileencoding
    if l:fileencoding ==# ''
        let l:fileencoding = &encoding
    endif
    if l:fileencoding ==# ''
        let l:fileencoding = 'unknown encoding'
    endif
    if l:fileencoding ==# 'utf-8'
        let l:fileencoding = ''
    endif
    return l:fileencoding
endfunction

function! jqnostatusline#functions#file_format() abort
    let l:fileformat = &fileformat
    if l:fileformat ==# ''
        let l:fileformat = 'unknown format'
    endif
    if l:fileformat ==# 'unix'
        let l:fileformat = ''
    endif
    return l:fileformat
endfunction

function! jqnostatusline#functions#file_type() abort
    let l:filetype = &filetype
    if l:filetype ==# ''
        let l:filetype = g:jqnostatusline#constants#EMPTY
    endif
    return l:filetype
endfunction

function! jqnostatusline#functions#metadata() abort
    let l:fileencoding = jqnostatusline#functions#file_encoding()
    if l:fileencoding !=# ''
        let l:fileencoding .= g:jqnostatusline#constants#PIPE
    endif

    let l:fileformat = jqnostatusline#functions#file_format()
    if l:fileformat !=# ''
        let l:fileformat .= g:jqnostatusline#constants#PIPE
    endif

    let l:filetype = jqnostatusline#functions#file_type()

    return l:fileencoding . l:fileformat . l:filetype
endfunction

function! jqnostatusline#functions#lsp_status() abort
    return exists('g:did_coc_loaded') ? coc#status() : ''
endfunction

function! jqnostatusline#functions#status() abort
    let l:counts = ale#statusline#Count(bufnr('%'))
    let l:error_count = l:counts.error + l:counts.style_error
    let l:warning_count = l:counts.total - l:error_count
    let l:ok = l:counts.total == 0 ? g:jqnostatusline#constants#OK : ''
    let l:warning = l:warning_count > 0 ? g:jqnostatusline#constants#WARNING . printf('%d', l:warning_count) : ''
    let l:error = l:error_count > 0 ? g:jqnostatusline#constants#ERROR . printf('%d', l:error_count) : ''

    return {'ok': l:ok, 'warning': l:warning, 'error': l:error}
endfunction
