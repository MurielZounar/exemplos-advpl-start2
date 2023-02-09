#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function String
  Fun��o desenvolvida pra exemplificar o uso do operador de concatena��o
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function String()
  Local cTexto1      := 'Texto 1 - '
  Local cTexto2      := ' Texto 2 - '
  Local cTexto3      := ' Texto 3'
  Local cTextoFinal  := ''

  //? Concatena��o
  cTextoFinal := cTexto1 + cTexto2 + cTexto3
  FwAlertSuccess('Concatena��o: ' + cTextoFinal, 'Operadores de String')
Return
