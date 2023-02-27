#INCLUDE 'TOTVS.CH'

User Function Cidades()
  // Local aCidades[4,2]  //? Declarando o array com quatro linhas e 2 colunas
  // Local aCidades[4][2] //? Declarando exatamente a mesma coisa que o array anterior
  // Local aCidades := Array(4, 2) //? Mesma declaração, mas com o uso da função Array()
  Local aCidades := {} //? Declarando o Array vazio

  //? Quando declaramos um array com uma das 3 primeiras formas, devemos popular o array da seguinte forma:
  // aCidades[1][1] := 'Jundiai'
  // aCidades[1][2] := '13201-000'
  // aCidades[2][1] := 'Campinas'
  // aCidades[2][2] := '13000-000'
  // aCidades[3][1] := 'São Paulo'
  // aCidades[3][2] := '01014-010
  // aCidades[4][1] := 'Americana'
  // aCidades[4][2] := '13400-000'

  //? Adicionando valores ao array. Obs: Esse é uma array bidimensional (Matriz)
  //?              Coluna 1  ,   Coluna 2
  //?               Cidade          CEP
  AADD(aCidades, {'Jundiai',   '13201-000'}) //? Linha 1
  AADD(aCidades, {'Campinas',  '13000-000'}) //? Linha 2
  AADD(aCidades, {'São Paulo', '01014-010'}) //? Linha 3
  AADD(aCidades, {'Americana', '13400-000'}) //? Linha 4

  FwAlertInfo(ArrToKStr(aCidades, CRLF), 'Cidades')
  
  FwAlertInfo('Cidade: ' + aCidades[1][1] + CRLF +; //? imprimindo [Linha 1][Coluna 1] 
              'CEP: ' + aCidades[1][2], 'Cidade')   //? imprimindo [Linha 1][Coluna 2] 

  //? Essa mensagem imprimirá exatamente a mesma coisa que a mensagem anterior
  // FwAlertInfo('Cidade: ' + aCidades[1, 1] + CRLF +;
  //             'CEP: ' + aCidades[1, 2], 'Cidade')
Return
