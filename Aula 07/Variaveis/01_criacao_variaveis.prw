//* Diretivas
#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'

#DEFINE cNome 'Muriel'

User Function Criacao()
  Local nValor  := 100 //* Nome Ok
  Local _nValor := 200 //* Nome Ok
  //Local 1Valor  := 100 //! Nome Inv�lido
  //Local :Valor  := 200 //! Nome Inv�lido

  Alert('Valor Mensal: ' + CVALTOCHAR(cNome))
Return
