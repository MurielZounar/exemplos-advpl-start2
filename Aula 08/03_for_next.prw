#INCLUDE 'TOTVS.CH'

User Function ExemploForNext()
  Local cMsg  := ''
  Local nCont := 0

  for nCont := 1 to 10
      cMsg += cValToChar(nCont) + CRLF //* Concatena o conte�do anterior de cMsg com o conte�do de nCont e avan� para a pr�xima linha.
  next

  FwAlertInfo(cMsg, 'Resultado')
Return
