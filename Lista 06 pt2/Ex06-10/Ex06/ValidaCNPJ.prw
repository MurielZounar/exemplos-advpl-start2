#INCLUDE 'TOTVS.CH'

User Function ValidaCNPJ()
  Local lRet := .T.

  if Empty(M->A2_PAIS) // Verifica se o campo "Pa�s" est� preenchido, se n�o estiver, entrar� no if e retonar� o valor .F. para o PE.
    lRet := .F.
    Help(NIL, NIL, 'O campo <b>Pa�s</b> deve ser preenchido.', NIL, 'Pa�s n�o seleciondo', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione o Pa�s'})
  elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) // Verifica se o campo "Pa�s" est� preenchido, com o valor "105", e o caompo CNPJ est� preenchido, se estiver entrar� no if e retonar� o valor .F. para o PE.
      lRet := .F.
      Help(NIL, NIL, 'O campo <b>CNPJ</b> deve ser preenchido.', NIL, 'Campo CNPJ n�o foi preenchido', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o CNPJ do cliente.'}) 
  endif
Return lRet

//? Obs: A fun��o "help" � respons�vel por apresentar uma mensagem de erro com 3 campos: Problema, Motivo, Solu��o.
//? Para saber mais sobre ela, consulte a documenta��o: https://tdn.totvs.com/display/public/framework/Help
