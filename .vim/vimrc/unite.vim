
" ######################################

" bundle管理    Unite.vim

" ######################################
" 起動時にインサートモードで開始

if v:version > 700

    let g:unite_enable_start_insert = 1
    let g:unite_update_time = 2000
    " shrtcut
    " call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
    " call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
    " call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
    " call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
    " call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
    " call unite#set_substitute_pattern('file', '^\\', '~/*')
    " call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
    " call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
    " call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
    " call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
    " call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '\$\w\+', 'subst': '\=eval(submatch(0))', 'priority': 200, })
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^@@', 'subst': '\=fnamemodify(expand("#"), ":p:h")."/"', 'priority': 2, })
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^@', 'subst': '\=getcwd()."/*"', 'priority': 1, })
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^;r', 'subst': '\=$VIMRUNTIME."/"', 'priority': 1, })
    "call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^\~', 'subst': escape($HOME, '\'), 'priority': -2, })
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '\\\@<! ', 'subst': '\\ ', 'priority': -20, })
    call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '\\ \@!', 'subst': '/', 'priority': -30, })
    if has('win32') || has('win64')
        call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^;p', 'subst': 'C:/Program Files/', 'priority': 1, })
        call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^;v', 'subst': '~/vimfiles/', 'priority': 1, })
    else
        call unite#custom#profile('files', 'substitute_patterns', { 'pattern': '^;v', 'subst': '~/.vim/', 'priority': 1, })
    endif

    " keymap
    nnoremap <silent> <Leader><C-f> :<C-u>UniteWithBufferDir -vertical -buffer-name=files file<CR>
    inoremap <silent> <Leader><C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> <C-b> :<C-u>Unite -vertical -buffer-name=files buffer file_mru bookmark<CR>
    inoremap <silent> <C-b> <ESC>:<C-u>Unite -vertical -buffer-name=files buffer file_mru bookmark<CR>

    " unite.vim上でのキーマッピング
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()
        " 単語単位からパス単位で削除するように変更
        imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
        " ESCキーを2回押すと終了する
        nmap <silent><buffer> <ESC><ESC> q
        imap <silent><buffer> <ESC><ESC> <ESC>q
    endfunction

    """ Valiables
    " 最近開いたファイル履歴の保存数
    let g:unite_source_file_mru_limit = 2000
    " Ignore file
    " let g:unite_source_file_rec_ignore_pattern = '\.pyc$'
    " call unite#custom_source('file_rec', 'ignore_pattern', '\.pyc$')

    " ######################################

    " unite-tag

    " ######################################
    " <C-]> 拡張
    " autocmd BufEnter *
                " \     if empty(&buftype)
                " \|            nnoremap <buffer> <Leader><C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
                " \|    endif
    " unite-tag
    nnoremap <silent> <Leader><C-e> :<C-u>Unite tag<CR>
    inoremap <silent> <Leader><C-e> <ESC>:<C-u>Unite tag<CR>

    " ######################################

    " unite-help

    " ######################################
    " " Execute help.
    " nnoremap <Leader><C-h>    :<C-u>Unite -start-insert help<CR>
    " " Execute help by cursor keyword.
    " nnoremap <silent> <Leader>g<C-h>    :<C-u>UniteWithCursorWord help<CR>

endif
