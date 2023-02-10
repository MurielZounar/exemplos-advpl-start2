#INCLUDE 'TOTVS.CH'

User Function ExemploDoCase()
  Local cNome := ''

  cNome := FwInputBox('Digite seu nome:', cNome) //* Função que solicita que o usuário digite um texto.

  do case
    case cNome == 'Muriel'  //* Compara o conteúdo da variável cNome com o nome 'Muriel'
      Alert('Olá, Muriel!') //? Se o conteúdo da variável for 'Muriel', essa linha é executada, caso contrário, passa para o próximo "Case"
    case cNome == 'Maria'  //* Compara o conteúdo da variável cNome com o nome 'Maria'
      Alert('Olá, Maria!') //? Se o conteúdo da variável for 'Maria', essa linha é exe  cutada, caso contrário, passa para o próximo "Case"
    case cNome == 'João'  //* Compara o conteúdo da variável cNome com o nome 'João'
      Alert('Olá, João!') //? Se o conteúdo da variável for 'João', essa linha é executada, caso contrário, passa para o próximo "Case"
    case cNome == 'Henrique'  //* Compara o conteúdo da variável cNome com o nome 'Henrique'
      Alert('Olá, Henrique!') //? Se o conteúdo da variável for 'Henrique', essa linha é executada, caso contrário, passa para o próximo "Case"
    otherwise
      Alert('Não te conheço!') //! Caso nenhuma das opções acima seja atendida, esse comano é executado.
  endcase
Return
