#INCLUDE 'TOTVS.CH'

User Function CarregCad()
  Local aBotao := {}
  Aadd(aBotao, {'Cad. Produtos', '', {||AxCadastro('SB1', 'Cadastro de Produtos')}, 'Cad. Produto'})
Return aBotao
