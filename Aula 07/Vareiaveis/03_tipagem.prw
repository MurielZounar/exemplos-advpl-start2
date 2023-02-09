#INCLUDE 'TOTVS.CH'

User Function Tipagem()
  Local nIdade := 28
  Local cNome  := 'Muriel'
  Local dData  := CTOD('01/03/1994')
  Local lVivo  := .T.
  Local aCores := {'Preto', 'Branco', 'Azul'}

  //? Mensagem con sinal de informa��o:
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


  // Obs: A vari�vel lVivo n�o foi utilizada, pois para conseguir utiliz�-la � necess�rio criar uma estrutura condicional.
Return
