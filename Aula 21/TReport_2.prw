#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function TReport
	Exemplo de impressão com TReport.
	@type  Function
	@author Muriel Zounar
	@since 30/03/2023
/*/
User Function TReport()
	Local cAlias	:= GetNextAlias()
	
	//? Instanciando a classe de impressão.
	Local oReport	:= TReport():New('TREPORT', 'Relatório de Compras por Produto',,{|oReport| Imprime(oReport)}, 'Esse relatório imprimirá todos os cadastros de clientes',.F.,,,, .T., .T.)	

	//? Instanciando a 1ª classe de sessão
	Local oSection1	:= TRSection():New(oReport, 'Produto',,,,,,,,,, .T.)
	Local oSection2 := TRSection():New(oSection1, 'Compras',,,,,,,,,, .T.)
	Local oBreak
	Private cCodProd  := ''
	Private cDescProd := ''
	Private cNumComp  := ''
	Private cDtComp   := ''
	Private cQtd      := ''
	Private cVlUnit   := ''
	Private cVlTot    := ''
	
	//* ------------------------------------------------------- Células da seção 1 -------------------------------------------------------
	//? Criando célula onde ficará o código e a descrição do produto
	TRCell():New(oSection1, 'PRODUTO', cAlias, 'PRODUTO',, 30,, {|| AllTrim(cCodProd + ' - ' + cDescProd)}, 'LEFT', .T., 'LEFT',,,,,, .T.)
	//* ----------------------------------------------------------------------------------------------------------------------------------
	
	//* ------------------------------------------------------- Células da seção 2 -------------------------------------------------------
	//? Criando célula onde ficará o número do pedido de compra
	TRCell():New(oSection2, 'NUM PEDIDO', cAlias, 'NUM PEDIDO',, 8,, {|| AllTrim(cNumComp)}, 'LEFT', .T., 'LEFT',,,,,, .T.)
	
	//? Criando célula onde ficará a data do pedido
	TRCell():New(oSection2, 'DATA PEDIDO', cAlias, 'DATA PEDIDO', PesqPict('SC7', 'C7_EMISSAO'), 12,, {|| AllTrim(cDtComp)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	//? Criando célula onde ficará a quantidade
	TRCell():New(oSection2, 'QUANT', cAlias, 'QUANT',, 10,, {|| AllTrim(cQtd)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	//? Criando célula onde ficará o Valor unitário
	TRCell():New(oSection2, 'VAL. UNIT.', cAlias, 'VAL. UNIT.',, 15,, {|| AllTrim(cVlUnit)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	
	//? Criando célula onde ficará o Valor Total
	TRCell():New(oSection2, 'VAL. TOTAL', cAlias, 'VAL. TOTAL',, 15,, {|| AllTrim(cVlTot)}, 'CENTER', .T., 'CENTER',,,,,, .T.)
	//* ----------------------------------------------------------------------------------------------------------------------------------

	oBreak := TRBreak():New(oSection1, oSection1:Cell('PRODUTO'), '', .T.)
	
	//? Faz a soma de todos os valores da coluna 'TOTAL'
	TRFunction():New(oSection2:Cell('VAL. TOTAL'), 'VALTOT', 'SUM', oBreak, 'VALOR TOTAL',,, .F., .F., .F.) 
	
	//? Exibindo a tela de configuração para a impressão do relatório
 	oReport:PrintDialog()
Return

//* Faz o print das colunas.
Static Function Imprime(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oSection1:Section(1)
	Local cAlias		:= GeraQuery()
	Local cUltProd  := ''
	Local nTotReg		:= 0
	
	DbSelectArea(cAlias)

	Count TO nTotReg //? "Count" contém a quantidade de registros da consulta. "Count TO nTotRec" passa a quant. p/ nTot

	//? determina o tamanho da barra de processamento
	oReport:SetMeter(nTotReg)

	//? Inicializa uma nova página para impressão
	oReport:StartPage()

	(cAlias)->(DBGoTop())
	
	//? Percorre todos os registros
	while (cAlias)->(!EoF())
		//? Se cancelar a operação
		if oReport:Cancel()
			Exit //! Cancela o loop, ou seja, para o processo.
		endif

		if AllTrim(cUltProd) <> AllTrim((cAlias)->B1_COD)
			if !Empty(cUltProd)
				oSection2:Finish() //? Finalizando seção 2
				oSection1:Finish() //? Finalizando seção 1
				oReport:EndPage()  //? Finalizando Página
			endif
			
			//? Inicializando a seção 1
			oSection1:Init()

			cCodProd  := AllTrim((cAlias)->B1_COD)
			cDescProd := AllTrim((cAlias)->B1_DESC)
			cUltProd  := cCodProd
		
			//? Imprimindo linha
			oSection1:PrintLine()

			//? Inicializando a seção 2
			oSection2:Init()
		endif

		cNumComp := (cAlias)->C7_NUM
		cDtComp  := DtoC(StoD((cAlias)->C7_EMISSAO))
		cQtd     := cValToChar((cAlias)->C7_QUANT)
		cVlUnit  := cValToChar((cAlias)->C7_PRECO)
		cVlTot   := cValToChar((cAlias)->C7_TOTAL)

		//? Imprimindo linha
		oSection2:PrintLine()

		//? Incrementa a barra de processamento
		oReport:IncMeter()

		(cAlias)->(DBSkip())
	enddo   

	//? Finalizando seção 1
		oSection1:Finish()	

	//? Finalizando seção 2
		oSection2:Finish()
	
	(cAlias)->(DBCloseArea())		

	//? Finalizando a página na impressão
	oReport:EndPage()
Return  

//* Monta a consuta SQL.
Static Function GeraQuery()
	Local cAlias := GetNextAlias()
	Local cQuery := ''

	cQuery += 'SELECT' + CRLF
	cQuery += '	  B1.B1_COD,' + CRLF
	cQuery += '   B1.B1_DESC,' + CRLF
	cQuery += '	  C7.C7_NUM,' + CRLF
	cQuery += '	  C7.C7_EMISSAO,' + CRLF
	cQuery += '	  C7.C7_QUANT,' + CRLF
	cQuery += '	  C7.C7_PRECO,' + CRLF
	cQuery += '	  C7.C7_TOTAL' + CRLF
	cQuery += 'FROM' + CRLF
	cQuery += '	 ' + RetSqlName('SB1') + ' B1' + CRLF
	cQuery += 'LEFT OUTER JOIN ' + RetSqlName('SC7') + ' C7' + CRLF
	cQuery += '	  ON B1.B1_COD = C7.C7_PRODUTO' + CRLF
	cQuery += 'WHERE' + CRLF
	cQuery += "	  B1.D_E_L_E_T_ = ' '" + CRLF
	cQuery += "	  AND C7.D_E_L_E_T_ = ' '" + CRLF
	cQuery += 'ORDER BY' + CRLF
	cQuery += '	  B1.B1_COD' + CRLF

	TCQUERY cQuery NEW ALIAS &cAlias
Return cAlias
