if exists('g:loaded_jqno_statusline')
    finish
endif
let g:loaded_jqno_statusline = 1

if !exists('g:jqno_statusline')
    let g:jqno_statusline = 'bubble'
endif

augroup JqnoStatusLineHighlights
    autocmd!
    autocmd ColorScheme * call jqnostatusline#switch#highlight(g:jqno_statusline)
augroup END

set laststatus=2
set noshowmode
set statusline=%!jqnostatusline#switch#statusline(g:jqno_statusline)
call jqnostatusline#switch#highlight(g:jqno_statusline)

