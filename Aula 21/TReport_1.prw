#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function TReport
	Exemplo de impressão com TReport.
	@type  Function
	@author Muriel Zounar
	@since 29/03/2023
/*/
User Function TReport()
	Local oReport := GeraReport() 
	
	//? Exibindo a tela de configuração para a impressão do relatório
 	oReport:PrintDialog()
Return

Static Function GeraReport()
	Local cAlias	:= GetNextAlias()
	
	//? Instanciando a classe de impressão.
	Local oReport	:= TReport():New('TREPORT', 'Relatório de Clientes',,{|oReport| Imprime(oReport, cAlias)}, 'Esse relatório imprimirá todos os cadastros de clientes',.F.,,,, .T., .T.)	

	//? Instanciando a classe de sessão (Ficará dentro da impressão)
	Local oSection1	:= TRSection():New(oReport, "Clientes Novos por UF",,,.F.,.T.)		

	// oReport:SetLandscape() //? Se deixarmos o 6º parâmetro do método contrutor (:New()) como ".T." não precisamos usar esse método. 

	//? Criando célula onde ficará o código
	TRCell():New(oSection1, 'A1_COD', 'SA1', 'Codigo', /*Picture*/, 8, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)

	//? Criando célula onde ficará o nome
	TRCell():New(oSection1, 'A1_NOME', 'SA1', 'Nome', /*Picture*/, 30, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando célula onde ficará o endereço
	TRCell():New(oSection1, 'A1_END', 'SA1', 'Endereco', /*Picture*/, 30, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando célula onde ficará o bairro
	TRCell():New(oSection1, 'A1_BAIRRO', 'SA1', 'Bairro', /*Picture*/, 20, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando célula onde ficará a cidade
	TRCell():New(oSection1, 'A1_MUN', 'SA1', 'Cidade', /*Picture*/, 20, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando célula onde ficará a UF
	TRCell():New(oSection1, 'A1_EST', 'SA1', 'UF', /*Picture*/, 4, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando célula onde ficará o CEP
	TRCell():New(oSection1, 'A1_CEP', 'SA1', 'CEP', '@E 99.999-99', 11, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
Return oReport

//* Faz o print das colunas.
Static Function Imprime(oReport, cAlias)
	Local oSection1 := oReport:Section(1)
	Local nTotReg		:= 0
	Local cQuery		:= GeraQuery()	
	
	DBUseArea(.T., 'TOPCONN', TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)	

	//*------------------------------------------------------------------------------------------------------------------------
	   //? DBUseArea: Abre uma tabela de dados na área de trabalho atual ou na primeira área de trabalho disponível.
		   //TODO: https://tdn.totvs.com/pages/releaseview.action?pageId=23889335
	
	  //? TCGenQry: Determina que a próxima chamada à DBUseArea será a abertura de uma Query e não de tabela.
		   //TODO: https://tdn.totvs.com/display/tec/TCGenQry
	//*------------------------------------------------------------------------------------------------------------------------

	Count TO nTotReg //? "Count" contém a quantidade de registros da consulta. "Count TO nTotRec" passa a quant. p/ nTot

	//? Define o número máximo para a barra de progressão
	oReport:SetMeter(nTotReg)

	//? Define o título do Relatório
	oReport:SetTitle('Relatório de Clientes')

	//? Inicializa uma nova página para impressão
	oReport:StartPage()

	oSection1:Init()  
	(cAlias)->(DBGoTop())
	
	//? Percorre todos os registros
	while !(cAlias)->(EoF())
		//? Se cancelar a operação
		if oReport:Cancel() //! Cancela o loop, ou seja, o processo.
			Exit
		endif

		//? Setando o conteúdo do registro posicionado na coluna "Código" da seção
		oSection1:Cell('Codigo'):SetValue((cAlias)->A1_COD)

		//? Setando o conteúdo do registro posicionado na coluna "Nome" da seção
		oSection1:Cell('Nome'):SetValue((cAlias)->A1_NOME)
		
		//? Setando o conteúdo do registro posicionado na coluna "Endereço" da seção
		oSection1:Cell('Endereco'):SetValue((cAlias)->A1_END)
		
		//? Setando o conteúdo do registro posicionado na coluna "Bairro" da seção
		oSection1:Cell('Bairro'):SetValue((cAlias)->A1_BAIRRO)
		
		//? Setando o conteúdo do registro posicionado na coluna "Cidade" da seção
		oSection1:Cell('Cidade'):SetValue((cAlias)->A1_MUN)
		
		//? Setando o conteúdo do registro posicionado na coluna "UF" da seção
		oSection1:Cell('UF'):SetValue((cAlias)->A1_EST)
		
		//? Setando o conteúdo do registro posicionado na coluna "Cep" da seção
		oSection1:Cell('CEP'):SetValue((cAlias)->A1_CEP)

		//? Imprimindo (gerando) a linha
		oSection1:PrintLine()

		//? Imprimindo uma linha fina
		oReport:ThinLine()

		//? Imcrementando a barra de progressão
		oReport:IncMeter()

		(cAlias)->(DBSkip())
	enddo   
	
	(cAlias)->(DBCloseArea())

	//? Finalizando a impressão da seção
	oSection1:Finish()			

	//? Finalizando a página na impressão
	oReport:EndPage()
Return  

//* Monta a consuta SQL.
Static Function GeraQuery()
	Local cQuery := ''

	cQuery += 'SELECT A1_COD, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP' + CRLF
	cQuery += 'FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
Return cQuery
