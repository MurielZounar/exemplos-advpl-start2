#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CopiaArq
  Função para exemplificar como copiar arquivos de uma pasta para outra através do ADVPL.
  @type  Function
  @author Muriel Zounar de Santana
  @since 14/04/2023
  /*/
User Function CopiaArq()
  Local cPastaOrig := 'C:\Users\Muriel Zounar\Desktop\PastaTeste\' //? Pasta onde os arquivos estão inicialmente - Origem
  Local cPastaDest := '\Pasta Muriel\' //? Pasta onde os arquivos serão salvos (dentro da protheus_data) - Destino
  //? Pegando os dados de todos os arquivos exeistentes dentro da pasta de origem
  Local aArquivos  := Directory(cPastaOrig + '*.*' /*Caminho + Tipos de Arquivos*/, 'D' /*Atribuos*/,/*Comp*/,/*Case Sensitive*/, 1 /*Ordenação dos arquivos*/)
  Local nI         := 0

  if LEN(aArquivos) > 0
    for nI := 3 to LEN(aArquivos)
      //? Copiando os arquivos da pasta de origem para a pasta de destino. 
      if !CpyT2S(cPastaOrig + aArquivos[nI][1], cPastaDest)      
        MsgStop('Houve um erro ao excluir o arquivo ' + aArquivos[nI][1])
      endif
    next

    FwAlertSuccess('Arquivo(s) copiado(s) com sucesso!', 'Concluído!')
  else
    FwAlertInfo('Apasta não contem nenhum arquivo!', 'Atenção!')
  endif
Return
