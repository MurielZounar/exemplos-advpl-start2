#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MTA010OK
  Exemplo de utilização de um ponto de entrada "tradicional"
  @type  Function
  @author Muriel ZOunar
  @since 14/02/2023
  /*/
User Function A010TOK()
  Local aArea    := GetArea()
  Local aAreaB1  := SB1->(GetArea())
  Local lRetorno := .T.
	
	
		SB1->(RecLock('SB1', .F.))
			SB1->B1_DESC := 'TESTE - ' + M->B1_DESC
		SB1->(MsUnlock())

  // if ExistBlock('ConfirmaCadastro')
  //   lRetorno := ExecBlock('ConfirmaCadastro', .F., .F.)
  // else
  //   FwAlertError('Função não encontrada!', 'Erro!')
  // endif

  RestArea(aAreaB1)
  RestArea(aArea)
Return lRetorno
