#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function EscrCSV
  Fun��o para exemplificar a cria��o de arquivos CSV usando ADVPL
  @type  Function
  @author Muriel Zounar
  @since 14/04/2023
  /*/
User Function EscrCSV()
  Local cPasta   := PARAMIXB // 'C:\Users\Muriel Zounar\Desktop\'
  //? Definindo nome do arquivo como "TesteArq.txt" 
  Local cArquivo := 'Plan.csv'
  //? Instanciando a classe FWFileWriter (Respons�vel por criar o arquivo e escrever nele)
  Local oWriter  := FWFileWriter():New(cPasta + cArquivo, .T.)
  Local cTexto   := ''
    
  //? Verificando se o arquivo j� existe na pasta
  if File(cPasta + cArquivo)
    FwAlertInfo('O arquivo j� existe na pasta!', 'Aten��o')
  else
    //? Caso n�o consiga criar o arquivo, a mensagem ser� apresentada
    if !oWriter:Create()
      FwAlertError('Houve um erro ao gerar o arquivo: ' + CRLF + oWriter:Error():Message, 'Aten��o')
    else
      cTexto := 'Cadastro de Pessoas' + CRLF
      cTexto += 'Nome;Idade' + CRLF
      cTexto += 'Muriel;29' + CRLF
      cTexto += 'Gabrielle;28' + CRLF
      cTexto += 'Victor;19' + CRLF
      cTexto += 'Leticia;18' + CRLF

      //? Escrevendo no arquivo
      oWriter:Write(cTexto)
        
      //? Fechando o arquivo
      oWriter:Close()
        
      //? Perguntando se o usu�rio deseja abrir o arquivo criado
      if MsgYesNo('Arquivo gerado com sucesso (' + cPasta + cArquivo + ')!' + CRLF + 'Abrir arquivo?', 'Abrir?')
        ShellExecute('OPEN', cArquivo, '', cPasta, 1)
      endif
    endif
  endif
Return
