#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DelPasta
  Fun��o para exemplificar a exclus�o de pastas atrav�s do ADVPL.
  @type  Function
  @author Muriel Zounar de Santana
  @since 14/04/2023
  /*/
User Function DelPasta()
  Local cPasta    := 'C:\Users\Muriel Zounar\Desktop\PastaTeste\' //? Caminho da pasta que ser� exclu�da
  //? Pegando os dados de todos os arquivos exeistentes dentro da pasta
  Local aArquivos := Directory(cPasta + '*.*' /*Caminho + Tipos de Arquivos*/, 'D' /*Atribuos*/,/*Comp*/,/*Case Sensitive*/, 1 /*Ordena��o dos arquivos*/)
  Local nI        := 0

  //? Verificando se a pasta existe
  if ExistDir(cPasta)
    if MsgYesNo('Confirma a exclus�o da pasta?', 'Aten��o')
      //? Se a pasta tiver algum arquivo, executa o bloco de c�digo
      if LEN(aArquivos) > 0
        for nI := 3 to LEN(aArquivos)
          //? Apagando os arquivos 
          if FErase(cPasta + aArquivos[nI][1]) == -1 //? Se houver algum erro na dele��o, apresenta a mensagem
            MsgStop('Houve um erro ao excluir o arquivo ' + aArquivos[nI][1])
          endif
        next
      endif

      //? Apagando a pasta
      if DirRemove(cPasta) //? Se a dele��o funcionar...
        FwAlertSuccess('Pasta removida com sucesso!', 'Conclu�do!')
      else //? Sen�o...
        FwAlertError('Houve um erro ao remover a pasta!', 'Aten��o!')
      endif
    endif
  endif
Return
