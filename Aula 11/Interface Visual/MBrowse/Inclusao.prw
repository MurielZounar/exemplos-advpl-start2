#INCLUDE 'PROTHEUS.CH'

User Function Inclusao(cAlias, nReg, nOpc)
  Local cMsg := 'Esse bot�o abrir� a tela de inclus�o'
  Local lMax := '.T.' 

  FwAlertInfo(cMsg, 'Bem vindo!')

  AxInclui(cAlias, nReg, nOpc, NIL, NIL, NIL, lMax)
Return
