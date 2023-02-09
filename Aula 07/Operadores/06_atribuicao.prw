#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Atribuicao
  Fun��o desenvolvida pra exemplificar o uso dos operadores de atribui��o
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Atribuicao()
  Local nValor := 0

  //? Atribui��o em linha
  nValor := 10
  FwAlertSuccess(STR(nValor), 'Operadores de Atribui��o')

  //? Adi��o e Atribui��o em linha
  nValor += 10
  FwAlertSuccess(STR(nValor), 'Operadores de Atribui��o')

  //? Subtra��o e Atribui��o em linha
  nValor -= 5
  FwAlertSuccess(STR(nValor), 'Operadores de Atribui��o')
  
  //? Multiplica��o e Atribui��o em linha
  nValor *= 4
  FwAlertSuccess(STR(nValor), 'Operadores de Atribui��o')
  
  //? Divis�o e Atribui��o em linha
  nValor /= 6
  FwAlertSuccess(STR(nValor), 'Operadores de Atribui��o')
Return
