exe 'imap' '<C-X><C-R>' '<C-R>=ListRegisters()<CR>'

func! ListRegisters()
  let s = ''
  redir => s
  silent registers
  redir END
  let reg_list = []
  for reg in split(s, "\n")[1:]
      let reg_split = split(reg, "   ")
      let reg_dict = {"menu": reg_split[1], "abbr": reg_split[0], "word": reg_split[1]}
      call add(reg_list, reg_dict)
  endfor
  call complete(col('.'), reg_list)
  return ''
endfunc
