#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function String
  Função desenvolvida pra exemplificar o uso do operador de concatenação
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function String()
  Local cTexto1      := 'Texto 1 - '
  Local cTexto2      := ' Texto 2 - '
  Local cTexto3      := ' Texto 3'
  Local cTextoFinal  := ''

  //? Concatenação
  cTextoFinal := cTexto1 + cTexto2 + cTexto3
  FwAlertSuccess('Concatenação: ' + cTextoFinal, 'Operadores de String')
Return
