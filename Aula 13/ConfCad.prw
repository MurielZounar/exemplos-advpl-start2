#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ConfirmaExclusao
  Função responsável por perguntar se o usuário realmente quer excluir um cadastro de produto.
  @type  Function
  @author Muriel Zounar
  @since 14/02/2023
  /*/
User Function ConfirmaCadastro()
  Local lResposta := .F.
  Local cPergunta := 'Confirma o cadastro do produto?'

  lResposta := MSGYESNO(cPergunta, 'Tem certeza?')
Return lResposta
