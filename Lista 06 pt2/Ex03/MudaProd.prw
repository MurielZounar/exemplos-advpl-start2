#INCLUDE 'TOTVS.CH'

User Function MudaProd()
  Local aArea   := GetArea()
  Local aAreaC5 := SC5->(GetArea())
  Local aAreaC6 := SC6->(GetArea())
  Local cPed    := PARAMIXB // Parâmetro recebido do ExecBlock do PE.
  Local cText   := 'Inc. PE - '

  DbSelectArea('SC6') // Abertura da tabela
  DbSetOrder(1) // Selecionado Índice 1

  if DbSeek(xFilial('SC6') + cPed) // Verificando se existe algum registro que tenha o número do pedido fornecido pelo PE
    while SC6->C6_NUM == cPed // Passando por cada idem que tem o número do pedido selecionado.
      RecLock('SC6', .F.) // Bloqueando a tabela para poder alterar os dados
        SC6->C6_DESCRI := cText + SC6->C6_DESCRI // Atribuindo o valor "Inc. Pe - " + descrição do produto.
      SC6->(MsUnlock()) // Liberando o acesso à tabela
      
      SC6->(DbSkip()) // Avançando para o próximo registro
    enddo
  endif
  
  SC6->(DbCloseArea())
  
  RestArea(aArea)
  RestArea(aAreaC5)
  RestArea(aAreaC6)
Return
