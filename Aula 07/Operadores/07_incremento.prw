#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Incremento
  Função desenvolvida pra exemplificar o uso do operador de incremento
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Incremento()
  Local nValor1 := 10
  Local nValor2 := 0

  nValor2 := nValor1++ + nValor1
  FwAlertSuccess(STR(nValor2), 'Operador de Incremento')

  nValor1 := 10

  nValor2 := ++nValor1 + nValor1
  FwAlertSuccess(STR(nValor2), 'Operador de Incremento')
Return
