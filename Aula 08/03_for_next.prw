#INCLUDE 'TOTVS.CH'

User Function ExemploForNext()
  Local cMsg  := ''
  Local nCont := 0

  for nCont := 1 to 10
      cMsg += cValToChar(nCont) + CRLF //* Concatena o conteúdo anterior de cMsg com o conteúdo de nCont e avaná para a próxima linha.
  next

  FwAlertInfo(cMsg, 'Resultado')
Return
