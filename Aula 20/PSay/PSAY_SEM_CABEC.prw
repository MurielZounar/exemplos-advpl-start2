#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function PSAY
	Exemplo de relatório utilizando PSAY
	@type  Function
	@author Muriel Zounar
	@since 29/03/2023
	/*/
User Function PSAY()        
	Local cTitulo       := 'Cadastros de Clientes'
	Private cTamanho    := 'M'
	Private cNomeProg   := 'PSAY' //? Nome do programa para impressao no cabecalho
	Private aReturn     := {'Zebrado', 1, 'Administracao', 1, 2, '', '', 1}
	Private nLastKey    := 0
	Private cNomRel     := 'PSAY' //? Nome do arquivo usado para impressao em disco
	Private cAlias 	    := 'SA1'

	//? Monta a interface padrao com o usuario...
	cNomRel := SetPrint(cAlias, cNomeProg, '', @cTitulo, '', '', '', .F.,, .T., cTamanho,, .F.)

	//? Se pressionar "ESC" encerra o programa
	if nLastKey == 27
		FwAlertError('Operação cancelada pelo usuário!', 'CANCELADO!')
		Return
	endif

	//? Prepara o ambiente para impressão
	SetDefault(aReturn, cAlias,, .T., 1)

	//? Processamento. RPTSTATUS monta janela com a regua de processamento.
	RptStatus({|| Imprime(cTitulo)}, cTitulo)
Return

Static Function Imprime(cTitulo)
  Local cTraco		 := '----------------------------------------'
	Local nLinha 		 := 2 //? Linha em que a impressão iniciará

	DbSelectArea('SA1')
	SA1->(DbSetOrder(1))

	//? Impressão dos dados de cada registro
	while !Eof() 
		@ nLinha, 00 PSAY PADR('Código: ', 10) + Alltrim(SA1->A1_COD)
		nLinha++

		@ nLinha, 00 PSAY PADR('Nome: ', 10) + Alltrim(SA1->A1_NOME)
		nLinha++

		@ nLinha, 00 PSAY PADR('Endereço: ', 10) + Alltrim(SA1->A1_END)
		nLinha++
		
		@ nLinha, 00 PSAY PADR('Bairro: ', 10) + Alltrim(SA1->A1_BAIRRO)
		nLinha++
		
		@ nLinha, 00 PSAY PADR('Cidade: ', 10) + Alltrim(SA1->A1_MUN)
		nLinha++
		
		@ nLinha, 00 PSAY PADR('UF:', 10) + Alltrim(SA1->A1_EST)
		nLinha++
		
		@ nLinha, 00 PSAY PADR('CEP: ', 10) + Alltrim(SA1->A1_CEP)
		nLinha++
		
		@ nLinha,00 PSAY cTraco
		nLinha++
		
		SA1->(dbSkip())
  enddo

	//? Finaliza a execucao do relatorio...
	SET DEVICE TO SCREEN

	//? Se impressao em disco, chama o gerenciador de impressao...
	if aReturn[5] == 1
		SET PRINTER TO dbCommitAll()
		OurSpool(cNomRel) //? Gerenciador de impressão do Protheus
	endif

	//? Descarrega o spool de impressão
	MS_FLUSH()
Return
      
