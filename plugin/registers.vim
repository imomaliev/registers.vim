imap <C-X><C-R> <C-R>=registers#ListRegisters()<CR>

func! registers#ListRegisters()
  let s = ''
  redir => s
  silent registers
  redir END
  let reg_list = []
  for reg_str in split(s, "\n")[1:]
      let abbr = reg_str[6:7]
      let word = reg_str[10:]
      let reg_dict = {"menu": word, "abbr": abbr, "word": "", "dup": v:true, "empty": v:true, "kind": "r"}
      call add(reg_list, reg_dict)
  endfor
  call complete(col('.'), reg_list)
  return ''
endfunc

func! registers#PasteRegister()
    if has_key(v:completed_item,"kind")
        if v:completed_item["kind"] == "r"
            exe "normal! i".getreg(v:completed_item["abbr"])."\<Right>"
        endif
    endif
    return ''
endfunc

augroup registers.vim
  autocmd!
  autocmd CompleteDone * call registers#PasteRegister()
augroup END
