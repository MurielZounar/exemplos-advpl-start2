#INCLUDE 'TOTVS.CH'

User Function CarregLoja()
  Local cNum  := StrZero(Randomize(1, 9), 2) // Gera um número randômico e acrescenta um 0 à esquerda.
  Local oObj  := PARAMIXB
  Local oView := NIL
  
  oObj:GetModel('SA2MASTER'):LoadValue('A2_LOJA', cNum) // Carrega o número gerado anteriormente no Modelo de Dados da rotina.
  oView := FwViewActive() // A classe FwViewActive() retorna o objeto da view (tela) aberta no momento, quando fazemos isso, podemos manipular a view.
  oView:Refresh() // O método Refresh faz com que a tela seja recarregada e receba todas as atualizações do Model, ou seja, carregará o conteúdo carregado na linha 8.
Return
