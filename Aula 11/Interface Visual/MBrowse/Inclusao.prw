#INCLUDE 'PROTHEUS.CH'

User Function Inclusao(cAlias, nReg, nOpc)
  Local cMsg := 'Esse botão abrirá a tela de inclusão'
  Local lMax := '.T.' 

  FwAlertInfo(cMsg, 'Bem vindo!')

  AxInclui(cAlias, nReg, nOpc, NIL, NIL, NIL, lMax)
Return
