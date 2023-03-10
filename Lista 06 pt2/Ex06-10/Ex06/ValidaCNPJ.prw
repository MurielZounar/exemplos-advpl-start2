#INCLUDE 'TOTVS.CH'

User Function ValidaCNPJ()
  Local lRet := .T.

  if Empty(M->A2_PAIS) // Verifica se o campo "País" está preenchido, se não estiver, entrará no if e retonará o valor .F. para o PE.
    lRet := .F.
    Help(NIL, NIL, 'O campo <b>País</b> deve ser preenchido.', NIL, 'País não seleciondo', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione o País'})
  elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) // Verifica se o campo "País" está preenchido, com o valor "105", e o caompo CNPJ está preenchido, se estiver entrará no if e retonará o valor .F. para o PE.
      lRet := .F.
      Help(NIL, NIL, 'O campo <b>CNPJ</b> deve ser preenchido.', NIL, 'Campo CNPJ não foi preenchido', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o CNPJ do cliente.'}) 
  endif
Return lRet

//? Obs: A função "help" é responsável por apresentar uma mensagem de erro com 3 campos: Problema, Motivo, Solução.
//? Para saber mais sobre ela, consulte a documentação: https://tdn.totvs.com/display/public/framework/Help
