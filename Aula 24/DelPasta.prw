#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DelPasta
  Função para exemplificar a exclusão de pastas através do ADVPL.
  @type  Function
  @author Muriel Zounar de Santana
  @since 14/04/2023
  /*/
User Function DelPasta()
  Local cPasta    := 'C:\Users\Muriel Zounar\Desktop\PastaTeste\' //? Caminho da pasta que será excluída
  //? Pegando os dados de todos os arquivos exeistentes dentro da pasta
  Local aArquivos := Directory(cPasta + '*.*' /*Caminho + Tipos de Arquivos*/, 'D' /*Atribuos*/,/*Comp*/,/*Case Sensitive*/, 1 /*Ordenação dos arquivos*/)
  Local nI        := 0

  //? Verificando se a pasta existe
  if ExistDir(cPasta)
    if MsgYesNo('Confirma a exclusão da pasta?', 'Atenção')
      //? Se a pasta tiver algum arquivo, executa o bloco de código
      if LEN(aArquivos) > 0
        for nI := 3 to LEN(aArquivos)
          //? Apagando os arquivos 
          if FErase(cPasta + aArquivos[nI][1]) == -1 //? Se houver algum erro na deleção, apresenta a mensagem
            MsgStop('Houve um erro ao excluir o arquivo ' + aArquivos[nI][1])
          endif
        next
      endif

      //? Apagando a pasta
      if DirRemove(cPasta) //? Se a deleção funcionar...
        FwAlertSuccess('Pasta removida com sucesso!', 'Concluído!')
      else //? Senão...
        FwAlertError('Houve um erro ao remover a pasta!', 'Atenção!')
      endif
    endif
  endif
Return
