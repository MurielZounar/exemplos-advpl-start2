#INCLUDE 'TOTVS.CH'

User Function ExemploForNext()
  Local cMsg  := ''
  Local nCont := 0

  for nCont := 1 to 10
    if nCont < 10
      cMsg += cValToChar(nCont) + ', ' //* Se o número for menor que 10, é acrescentado uma vírgula no final.
    else
      cMsg += cValToChar(nCont) //* Quando chega no último número (10) a vírgula não é acrescentada.
    endif
  next

  FwAlertInfo(cMsg, 'Resultado')
Return
