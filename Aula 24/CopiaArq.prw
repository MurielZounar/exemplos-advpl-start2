#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CopiaArq
  Fun��o para exemplificar como copiar arquivos de uma pasta para outra atrav�s do ADVPL.
  @type  Function
  @author Muriel Zounar de Santana
  @since 14/04/2023
  /*/
User Function CopiaArq()
  Local cPastaOrig := 'C:\Users\Muriel Zounar\Desktop\PastaTeste\' //? Pasta onde os arquivos est�o inicialmente - Origem
  Local cPastaDest := '\Pasta Muriel\' //? Pasta onde os arquivos ser�o salvos (dentro da protheus_data) - Destino
  //? Pegando os dados de todos os arquivos exeistentes dentro da pasta de origem
  Local aArquivos  := Directory(cPastaOrig + '*.*' /*Caminho + Tipos de Arquivos*/, 'D' /*Atribuos*/,/*Comp*/,/*Case Sensitive*/, 1 /*Ordena��o dos arquivos*/)
  Local nI         := 0

  if LEN(aArquivos) > 0
    for nI := 3 to LEN(aArquivos)
      //? Copiando os arquivos da pasta de origem para a pasta de destino. 
      if !CpyT2S(cPastaOrig + aArquivos[nI][1], cPastaDest)      
        MsgStop('Houve um erro ao excluir o arquivo ' + aArquivos[nI][1])
      endif
    next

    FwAlertSuccess('Arquivo(s) copiado(s) com sucesso!', 'Conclu�do!')
  else
    FwAlertInfo('Apasta n�o contem nenhum arquivo!', 'Aten��o!')
  endif
Return
