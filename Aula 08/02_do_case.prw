#INCLUDE 'TOTVS.CH'

User Function ExemploDoCase()
  Local cNome := ''

  cNome := FwInputBox('Digite seu nome:', cNome) //* Fun��o que solicita que o usu�rio digite um texto.

  do case
    case cNome == 'Muriel'  //* Compara o conte�do da vari�vel cNome com o nome 'Muriel'
      Alert('Ol�, Muriel!') //? Se o conte�do da vari�vel for 'Muriel', essa linha � executada, caso contr�rio, passa para o pr�ximo "Case"
    case cNome == 'Maria'  //* Compara o conte�do da vari�vel cNome com o nome 'Maria'
      Alert('Ol�, Maria!') //? Se o conte�do da vari�vel for 'Maria', essa linha � exe  cutada, caso contr�rio, passa para o pr�ximo "Case"
    case cNome == 'Jo�o'  //* Compara o conte�do da vari�vel cNome com o nome 'Jo�o'
      Alert('Ol�, Jo�o!') //? Se o conte�do da vari�vel for 'Jo�o', essa linha � executada, caso contr�rio, passa para o pr�ximo "Case"
    case cNome == 'Henrique'  //* Compara o conte�do da vari�vel cNome com o nome 'Henrique'
      Alert('Ol�, Henrique!') //? Se o conte�do da vari�vel for 'Henrique', essa linha � executada, caso contr�rio, passa para o pr�ximo "Case"
    otherwise
      Alert('N�o te conhe�o!') //! Caso nenhuma das op��es acima seja atendida, esse comano � executado.
  endcase
Return
