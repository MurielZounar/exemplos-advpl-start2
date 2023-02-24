#INCLUDE 'TOTVS.CH'

User Function VldAlt()
  Local cMsg := ''
  Local lRet := .T.

  if !INCLUI
    cMsg := 'Confirma a alteração?'
    lRet := MsgYesNo(cMsg)
  endif
Return lRet
