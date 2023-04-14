#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function LeCSV
  Fun��o para exemplificar como ler arquivos CSV
  @type  Function
  @author Muriel Zounar
  @since 13/04/2023
  /*/
User Function LeCSV()
  //? Definindo a pasta onde o arquivo est�
  Local cPasta    := 'C:\Users\Muriel Zounar\Desktop\PastaTeste\'
  //? Definindo nome do arquivo que ser� lido 
  Local cArquivo  := 'Plan.csv'
  //? Instanciando a classe FWFileReader (Respons�vel por ler o arquivo)
  Local oArq      := FWFileReader():New(cPasta + cArquivo)
  Local cTxtLinha := ''
  Local aLinha    := {}
  Local aConteudo := {}
  Local nI        := 0
 
  //? Verificando de se o arquivo pode ser aberto
  if oArq:Open()
    //? Verificando se � o fim do arquivo. Se n�o for, entra no if
    if !oArq:EoF()
      //? Fazendo a leitura enquanto houverem linhas a serem lidas
      while (oArq:HasLine())
          //? Capturando o o conte�do de todas as linhas de uma vez
          aConteudo := oArq:GetAllLines()
      enddo
    endif
    
    for nI := 1 to Len(aConteudo)
      if nI == 1
        //? Pegando o texto da segunda linha
        cTxtLinha := aConteudo[nI] + CRLF
      else
        //? Separando o texto da linha. O ponto de separa��o � o ";"
        aLinha := StrTokArr(aConteudo[nI], ';')
        cTxtLinha += aLinha[1] + ' - ' + aLinha[2]  + CRLF
      endif
    next

    //? Fechando o arquivo (Isso indica o fim do processamento)
    oArq:Close()
  endif

  //? Apresentando texto do arquivo em uma mensagem
  FwALertInfo(cTxtLinha, 'Conte�do do arquivo:')
Return
