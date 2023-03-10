#INCLUDE 'TOTVS.CH'

User Function CarregLoja()
  Local cNum  := StrZero(Randomize(1, 9), 2) // Gera um n�mero rand�mico e acrescenta um 0 � esquerda.
  Local oObj  := PARAMIXB
  Local oView := NIL
  
  oObj:GetModel('SA2MASTER'):LoadValue('A2_LOJA', cNum) // Carrega o n�mero gerado anteriormente no Modelo de Dados da rotina.
  oView := FwViewActive() // A classe FwViewActive() retorna o objeto da view (tela) aberta no momento, quando fazemos isso, podemos manipular a view.
  oView:Refresh() // O m�todo Refresh faz com que a tela seja recarregada e receba todas as atualiza��es do Model, ou seja, carregar� o conte�do carregado na linha 8.
Return
