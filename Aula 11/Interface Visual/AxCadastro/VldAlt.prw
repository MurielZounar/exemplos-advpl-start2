#INCLUDE 'TOTVS.CH'

User Function VldAlt()
  Local cMsg := ''
  Local lRet := .T.

  if !INCLUI
    cMsg := 'Confirma a altera��o?'
    lRet := MsgYesNo(cMsg)
  endif
Return lRet
