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
	Private m_pag			  := 1

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
	Local cCabec		 := ' CÓDIGO              NOME                        ENDEREÇO                  BAIRRO              CIDADE         UF        CEP      '
  Local cTraco		 := '---------------------------------------------------------------------------------------------------------------------------------'
	Local nLinha 		 := 8 //? Linha em que a impressão iniciará
	Local aColunas	 := {}

	//? Colunas para impressão
	Aadd(aColunas, 001)
	Aadd(aColunas, 012)
	Aadd(aColunas, 043)
	Aadd(aColunas, 074)
	Aadd(aColunas, 093.5)
	Aadd(aColunas, 110)
	Aadd(aColunas, 119)

	DbSelectArea('SA1')
	SA1->(DbSetOrder(1))

	//? Cabeçalho do Relatório
	Cabec(cTitulo, cCabec, '',, cTamanho)

	//? Impressão dos dados de cada registro em linha
	while !Eof() 
		@ nLinha, aColunas[1] PSAY PADR(Alltrim(SA1->A1_COD), 10)
		@ nLinha, aColunas[2] PSAY PADR(Alltrim(SA1->A1_NOME), 30)
		@ nLinha, aColunas[3] PSAY PADR(Alltrim(SA1->A1_END), 30)
		@ nLinha, aColunas[4] PSAY PADR(Alltrim(SA1->A1_BAIRRO), 20)
		@ nLinha, aColunas[5] PSAY PADR(Alltrim(SA1->A1_MUN), 20)
		@ nLinha, aColunas[6] PSAY PADR(Alltrim(SA1->A1_EST), 4)
		@ nLinha, aColunas[7] PSAY PADR(Alltrim(SA1->A1_CEP), 10)
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
      
