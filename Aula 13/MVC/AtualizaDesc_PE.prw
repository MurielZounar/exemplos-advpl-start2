#INCLUDE 'TOTVS.CH'

User Function Item()
  Local aParam   := PARAMIXB
  Local lRet     := .T.
  Local oObj     := Nil
  Local cIdPonto := ''
  Local cIdModel := ''

  if aParam <> NIL
    oObj     := aParam[1]
    cIdPonto := aParam[2]
    cIdModel := aParam[3]
      
    if cIdPonto == 'MODELCOMMITTTS'
      SB1->B1_DESC := ALLTRIM('PRDMANUAL - ' + M->B1_DESC)
    endif
  endif
Return lRet
