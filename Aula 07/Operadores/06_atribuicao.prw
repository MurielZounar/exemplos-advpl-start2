#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Atribuicao
  Função desenvolvida pra exemplificar o uso dos operadores de atribuição
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Atribuicao()
  Local nValor := 0

  //? Atribuição em linha
  nValor := 10
  FwAlertSuccess(STR(nValor), 'Operadores de Atribuição')

  //? Adição e Atribuição em linha
  nValor += 10
  FwAlertSuccess(STR(nValor), 'Operadores de Atribuição')

  //? Subtração e Atribuição em linha
  nValor -= 5
  FwAlertSuccess(STR(nValor), 'Operadores de Atribuição')
  
  //? Multiplicação e Atribuição em linha
  nValor *= 4
  FwAlertSuccess(STR(nValor), 'Operadores de Atribuição')
  
  //? Divisão e Atribuição em linha
  nValor /= 6
  FwAlertSuccess(STR(nValor), 'Operadores de Atribuição')
Return
