#INCLUDE 'TOTVS.CH'

#DEFINE nSize 12

User Function Meses()
  //? Declarando dessa forma, o array ser� criado com 12 posi��es com valor NIL (Nulo).
  // Local aMeses[12] 

  //? Declarando dessa forma, o array ser� criado com 12 posi��es com valor NIL (Nulo).
  // Local aMeses := Array(12) 

  //? Declarando dessa forma, � poss�vel atribuir o conte�do de cada posi��o do array.
  Local aMeses  := {'Janeiro', 'Fevereiro', 'Mar�o', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'}
  
  //? Declarando dessa forma, o array ser� criado sem nenhum conte�no, n�o haver� nem valor nulo.
  // Local aMeses2 := {}
  Local nCont   := 0

  //? Para adicionar elementos a um array declarado da 1� ou 2� forma, deria necess�rio atribuir os valores das seguintes formas: 

  // aMeses[1] := 'Janeiro'
  // aMeses[2] := 'Fevereiro'
  // aMeses[3] := 'Mar�o'
  // E assim sucessivamente...
  
  For nCont := 1 To nSize
    FwAlertInfo('Esse � o m�s ' + cValToChar(nCont), aMeses[nCont]) //? Imprimindo em uma mensagem cada m�s preenchido no array.
  Next

  // FwAlertInfo('Esse � o m�s ' + cValToChar(3), aMeses[3])

  // aMeses2 := aMeses //! Copia o Mapa do array, n�o o conte�do propriamente dito.
  // ACopy(aMeses, aMeses2) //* Para copiar o conte�do deve-se usar a fun��o ACopy()

  // FwAlertInfo('Esse � o m�s ' + cValToChar(3), aMeses2[3])

  //? Utilizando a fun��o "ACopy()" essa troca na descri��o dos meses acontecer� apenas no array aMeses2.
  // aMeses2[3] := 'Junho'
  // aMeses2[6] := 'Mar�o'

  //? Imprimindo meses 3 e 6 do array aMeses
  // FwAlertInfo('M�s 3: ' + aMeses[3] + CRLF + 'M�s 6: ' + aMeses[6], 'aMeses')

  //? Imprimindo meses 3 e 6 do array aMeses2
  // FwAlertInfo('M�s 3: ' + aMeses2[3] + CRLF + 'M�s 6: ' + aMeses2[6], 'aMeses2')  
Return
