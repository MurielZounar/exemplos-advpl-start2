//* Diretivas
#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'

#DEFINE cNome 'Muriel'

User Function Criacao()
  Local nValor  := 100 //* Nome Ok
  Local _nValor := 200 //* Nome Ok
  //Local 1Valor  := 100 //! Nome Inválido
  //Local :Valor  := 200 //! Nome Inválido

  Alert('Valor Mensal: ' + CVALTOCHAR(cNome))
Return
