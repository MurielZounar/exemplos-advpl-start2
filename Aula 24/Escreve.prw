#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Escreve
  Fun��o para exemplificar como criar/escrever arquivos de texto
  @type  Function
  @author Muriel Zounar
  @since 13/04/2023
  /*/
User Function Escreve()
  //? Definindo a pasta como o Desktop do Windows
  Local cPasta   := PARAMIXB // 'C:\Users\Muriel Zounar\Desktop\'
  //? Definindo nome do arquivo como "TesteArq.txt" 
  Local cArquivo := 'TesteArq.txt'
  //? Instanciando a classe FWFileWriter (Respons�vel por criar o arquivo e escrever nele)
  Local oWriter := FWFileWriter():New(cPasta + cArquivo, .T.)
    
  //? Verificando se o arquivo j� existe na pasta
  if File(cPasta + cArquivo)
    FwAlertInfo('O arquivo j� existe na pasta!', 'Aten��o')
  else
    //? Caso n�o consiga criar o arquivo, a mensagem ser� apresentada
    if !oWriter:Create()
      FwAlertError('Houve um erro ao gerar o arquivo: ' + CRLF + oWriter:Error():Message, 'Aten��o')
    else
      //? Escrevendo no arquivo
      oWriter:Write('Ol�!' + CRLF + 'Esse � um teste para ver se o programa funciona!')
        
      //? Fechando o arquivo
      oWriter:Close()
        
      //? Perguntando se o usu�rio deseja abrir o arquivo criado
      if MsgYesNo('Arquivo gerado com sucesso (' + cPasta + cArquivo + ')!' + CRLF + 'Abrir arquivo?', 'Abrir?')
        ShellExecute('OPEN', cArquivo, '', cPasta, 1)
      endif
    endif
  endif
Return
