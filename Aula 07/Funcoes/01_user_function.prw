#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ExemploUser
  Fun��o de Exemplo para os Starters
  @type  Function
  @author Muriel Zounar
  @since 08/02/2023
  /*/
User Function ExemploUserFunction()
  Local cTexto := 'Esse texto ser� apresentado em uma mensagem!'

  FwAlertInfo(cTexto, 'Mensagem')
Return
