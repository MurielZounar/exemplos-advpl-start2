#INCLUDE 'PROTHEUS.CH'

User Function CadSA2()
  Local cAlias  := 'SA2'
  Local cTitulo := 'Cadastro de Fornecedores'
  Local lVldExc := 'U_VldExc()'
  Local lVldAlt := 'U_VldAlt()'

  DbSelectArea(cAlias)
  DbSetOrder(1)
  AxCadastro(cAlias, cTitulo, lVldExc, lVldAlt)
Return
