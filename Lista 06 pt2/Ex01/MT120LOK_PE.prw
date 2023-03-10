#INCLUDE 'TOTVS.CH'

User Function MT120LOK()
  Local nPosTES  := aScan(aHeader,{|x| AllTrim(x[2]) == 'C7_TES'}) // Retorna a posição do campo Tipo de Entrada no grid dos produtos do Pedido de Compra
  Local lValido  := .T.
  
  if Empty(aCols[n][nPosTES]) // Verifica se o campo Tipo de Entrada está preenchido
    lValido := .F.
    FwAlertError('O campo <b>Tipo de Entrada</b> deve ser preenchido.', 'ERRO!')
  endif
Return lValido
