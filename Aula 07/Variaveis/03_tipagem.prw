#INCLUDE 'TOTVS.CH'

User Function Tipagem()
  Local nIdade := 28
  Local cNome  := 'Muriel'
  Local dData  := CTOD('01/03/1994')
  Local lVivo  := .T.
  Local aCores := {'Preto', 'Branco', 'Azul'}

  //? Mensagem con sinal de informação:
  FwAlertInfo('Nome: ' + cNome + CRLF +;
              'Idade: ' + STR(nIdade) + CRLF +;
              'Nascimento: ' + DTOC(dData) + CRLF +;
              'Cores: ' + aCores[1] + ', ' + aCores[2] + ', ' + aCores[3], 'Info')

  //* Mensagem com sinal de sucesso:
  FwAlertSuccess('Nome: ' + cNome + CRLF +;
                 'Idade: ' + STR(nIdade) + CRLF +;
                 'Nascimento: ' + DTOC(dData) + CRLF +;
                 'Cores: ' + aCores[1] + ', ' + aCores[2] + ', ' + aCores[3], 'Success')

  //! Mensagem com sinal de erro: 
  FwAlertError('Nome: ' + cNome + CRLF +;
               'Idade: ' + STR(nIdade) + CRLF +;
               'Nascimento: ' + DTOC(dData) + CRLF +;
               'Cores: ' + aCores[1] + ', ' + aCores[2] + ', ' + aCores[3], 'Error')


  // Obs: A variável lVivo não foi utilizada, pois para conseguir utilizá-la é necessário criar uma estrutura condicional.
Return
