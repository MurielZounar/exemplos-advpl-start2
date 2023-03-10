#INCLUDE 'TOTVS.CH'

User Function MT120LOK()
  Local nPosTES  := aScan(aHeader,{|x| AllTrim(x[2]) == 'C7_TES'}) // Retorna a posi��o do campo Tipo de Entrada no grid dos produtos do Pedido de Compra
  Local lValido  := .T.
  
  if Empty(aCols[n][nPosTES]) // Verifica se o campo Tipo de Entrada est� preenchido
    lValido := .F.
    FwAlertError('O campo <b>Tipo de Entrada</b> deve ser preenchido.', 'ERRO!')
  endif
Return lValido
