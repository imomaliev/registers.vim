exe 'imap' '<C-X><C-R>' '<C-R>=ListRegisters()<CR>'

func! ListRegisters()
  let s = ''
  redir => s
  silent registers
  redir END
  let reg_list = []
  for reg_str in split(s, "\n")[1:]
      let abbr = reg_str[1:2]
      let word = reg_str[5:]
      let reg_dict = {"menu": word, "abbr": abbr, "word": "", "dup": v:true, "empty": v:true}
      call add(reg_list, reg_dict)
  endfor
  call complete(col('.'), reg_list)
  return ''
endfunc

func! PasteRegister()
    exe "normal! i".getreg(v:completed_item["abbr"])."\<Right>"
endfunc

augroup registers
  autocmd!
  autocmd CompleteDone * call PasteRegister()
augroup END
