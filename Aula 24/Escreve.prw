#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Escreve
  Função para exemplificar como criar/escrever arquivos de texto
  @type  Function
  @author Muriel Zounar
  @since 13/04/2023
  /*/
User Function Escreve()
  //? Definindo a pasta como o Desktop do Windows
  Local cPasta   := PARAMIXB // 'C:\Users\Muriel Zounar\Desktop\'
  //? Definindo nome do arquivo como "TesteArq.txt" 
  Local cArquivo := 'TesteArq.txt'
  //? Instanciando a classe FWFileWriter (Responsável por criar o arquivo e escrever nele)
  Local oWriter := FWFileWriter():New(cPasta + cArquivo, .T.)
    
  //? Verificando se o arquivo já existe na pasta
  if File(cPasta + cArquivo)
    FwAlertInfo('O arquivo já existe na pasta!', 'Atenção')
  else
    //? Caso não consiga criar o arquivo, a mensagem será apresentada
    if !oWriter:Create()
      FwAlertError('Houve um erro ao gerar o arquivo: ' + CRLF + oWriter:Error():Message, 'Atenção')
    else
      //? Escrevendo no arquivo
      oWriter:Write('Olá!' + CRLF + 'Esse é um teste para ver se o programa funciona!')
        
      //? Fechando o arquivo
      oWriter:Close()
        
      //? Perguntando se o usuário deseja abrir o arquivo criado
      if MsgYesNo('Arquivo gerado com sucesso (' + cPasta + cArquivo + ')!' + CRLF + 'Abrir arquivo?', 'Abrir?')
        ShellExecute('OPEN', cArquivo, '', cPasta, 1)
      endif
    endif
  endif
Return
