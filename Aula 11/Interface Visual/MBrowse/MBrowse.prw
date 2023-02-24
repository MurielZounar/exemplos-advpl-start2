#INCLUDE 'PROTHEUS.CH'

User Function CadSA1()
  Local cAlias      := 'SA1'
  Private cCadastro := 'Meus Clientes'
  Private aRotina  := {}

  Aadd(aRotina, {'Pesquisar',    'AxPesqui',   0, 1})
  Aadd(aRotina, {'Incluir',      'AxInclui',   0, 3})
  Aadd(aRotina, {'Visualizar',   'AxVisual',   0, 2})
  Aadd(aRotina, {'Alterar',      'AxAltera',   0, 4})
  Aadd(aRotina, {'Excluir',      'AxDeleta',   0, 5})
  Aadd(aRotina, {'Fornecedores', 'U_CadSA2',   0, 6})
  Aadd(aRotina, {'Botão',        'U_MeuBotao', 0, 6})

  DbSelectArea('SA1')
  DbSetOrder(1)

  MBrowse(NIL, NIL, NIL, NIL, cAlias)

  DbCloseArea()
Return
