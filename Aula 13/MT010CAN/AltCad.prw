#INCLUDE 'TOTVS.CH'

User Function AltCad()
  Local aArea   := GetArea()
  Local aAreaB1 := SB1->(GetArea())
  Local cTxtPad := 'Cad. Manual - '
  Local cProd   := cTxtPad + SB1->B1_DESC

  RecLock('SB1', .F.)
    SB1->B1_DESC := cProd
  SB1->(MSUnlock())
    
  RestArea(aArea)
  RestArea(aAreaB1)
Return
