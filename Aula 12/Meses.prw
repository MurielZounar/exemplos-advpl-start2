#INCLUDE 'TOTVS.CH'

#DEFINE nSize 12

User Function Meses()
  //? Declarando dessa forma, o array será criado com 12 posições com valor NIL (Nulo).
  // Local aMeses[12] 

  //? Declarando dessa forma, o array será criado com 12 posições com valor NIL (Nulo).
  // Local aMeses := Array(12) 

  //? Declarando dessa forma, é possível atribuir o conteúdo de cada posição do array.
  Local aMeses  := {'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'}
  
  //? Declarando dessa forma, o array será criado sem nenhum conteúno, não haverá nem valor nulo.
  // Local aMeses2 := {}
  Local nCont   := 0

  //? Para adicionar elementos a um array declarado da 1ª ou 2ª forma, deria necessário atribuir os valores das seguintes formas: 

  // aMeses[1] := 'Janeiro'
  // aMeses[2] := 'Fevereiro'
  // aMeses[3] := 'Março'
  // E assim sucessivamente...
  
  For nCont := 1 To nSize
    FwAlertInfo('Esse é o mês ' + cValToChar(nCont), aMeses[nCont]) //? Imprimindo em uma mensagem cada mês preenchido no array.
  Next

  // FwAlertInfo('Esse é o mês ' + cValToChar(3), aMeses[3])

  // aMeses2 := aMeses //! Copia o Mapa do array, não o conteúdo propriamente dito.
  // ACopy(aMeses, aMeses2) //* Para copiar o conteúdo deve-se usar a função ACopy()

  // FwAlertInfo('Esse é o mês ' + cValToChar(3), aMeses2[3])

  //? Utilizando a função "ACopy()" essa troca na descrição dos meses acontecerá apenas no array aMeses2.
  // aMeses2[3] := 'Junho'
  // aMeses2[6] := 'Março'

  //? Imprimindo meses 3 e 6 do array aMeses
  // FwAlertInfo('Mês 3: ' + aMeses[3] + CRLF + 'Mês 6: ' + aMeses[6], 'aMeses')

  //? Imprimindo meses 3 e 6 do array aMeses2
  // FwAlertInfo('Mês 3: ' + aMeses2[3] + CRLF + 'Mês 6: ' + aMeses2[6], 'aMeses2')  
Return
