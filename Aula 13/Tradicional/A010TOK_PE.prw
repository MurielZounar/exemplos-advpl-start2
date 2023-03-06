#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MTA010OK
  Exemplo de utiliza��o de um ponto de entrada "tradicional"
  @type  Function
  @author Muriel ZOunar
  @since 14/02/2023
  /*/
User Function A010TOK()
  Local aArea    := GetArea()
  Local aAreaB1  := SB1->(GetArea())
  Local lRetorno := .F. 

  if ExistBlock('ConfirmaCadastro')
    lRetorno := ExecBlock('ConfirmaCadastro', .F., .F.)
  else
    FwAlertError('Fun��o n�o encontrada!', 'Erro!')
  endif

  RestArea(aAreaB1)
  RestArea(aArea)
Return lRetorno
