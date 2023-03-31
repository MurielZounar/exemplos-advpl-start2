#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} User Function TReport
	Exemplo de impress�o com TReport.
	@type  Function
	@author Muriel Zounar
	@since 29/03/2023
/*/
User Function TReport()
	Local oReport := GeraReport() 
	
	//? Exibindo a tela de configura��o para a impress�o do relat�rio
 	oReport:PrintDialog()
Return

Static Function GeraReport()
	Local cAlias	:= GetNextAlias()
	
	//? Instanciando a classe de impress�o.
	Local oReport	:= TReport():New('TREPORT', 'Relat�rio de Clientes',,{|oReport| Imprime(oReport, cAlias)}, 'Esse relat�rio imprimir� todos os cadastros de clientes',.F.,,,, .T., .T.)	

	//? Instanciando a classe de sess�o (Ficar� dentro da impress�o)
	Local oSection1	:= TRSection():New(oReport, "Clientes Novos por UF",,,.F.,.T.)		

	// oReport:SetLandscape() //? Se deixarmos o 6� par�metro do m�todo contrutor (:New()) como ".T." n�o precisamos usar esse m�todo. 

	//? Criando c�lula onde ficar� o c�digo
	TRCell():New(oSection1, 'A1_COD', 'SA1', 'Codigo', /*Picture*/, 8, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)

	//? Criando c�lula onde ficar� o nome
	TRCell():New(oSection1, 'A1_NOME', 'SA1', 'Nome', /*Picture*/, 30, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando c�lula onde ficar� o endere�o
	TRCell():New(oSection1, 'A1_END', 'SA1', 'Endereco', /*Picture*/, 30, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando c�lula onde ficar� o bairro
	TRCell():New(oSection1, 'A1_BAIRRO', 'SA1', 'Bairro', /*Picture*/, 20, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando c�lula onde ficar� a cidade
	TRCell():New(oSection1, 'A1_MUN', 'SA1', 'Cidade', /*Picture*/, 20, /*Pixel*/, /*Code-Block*/, 'LEFT', .T., 'LEFT', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando c�lula onde ficar� a UF
	TRCell():New(oSection1, 'A1_EST', 'SA1', 'UF', /*Picture*/, 4, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
	
	//? Criando c�lula onde ficar� o CEP
	TRCell():New(oSection1, 'A1_CEP', 'SA1', 'CEP', '@E 99.999-99', 11, /*Pixel*/, /*Code-Block*/, 'CENTER', .T., 'CENTER', /*Comp.*/,/*Espac. Entre Cel.*/, .T., /*Cor Fundo*/, /**Cor Fonte*/, .T.)
Return oReport

//* Faz o print das colunas.
Static Function Imprime(oReport, cAlias)
	Local oSection1 := oReport:Section(1)
	Local nTotReg		:= 0
	Local cQuery		:= GeraQuery()	
	
	DBUseArea(.T., 'TOPCONN', TcGenQry(/*Compat*/, /*Compat*/, cQuery), cAlias, .T., .T.)	

	//*------------------------------------------------------------------------------------------------------------------------
	   //? DBUseArea: Abre uma tabela de dados na �rea de trabalho atual ou na primeira �rea de trabalho dispon�vel.
		   //TODO: https://tdn.totvs.com/pages/releaseview.action?pageId=23889335
	
	  //? TCGenQry: Determina que a pr�xima chamada � DBUseArea ser� a abertura de uma Query e n�o de tabela.
		   //TODO: https://tdn.totvs.com/display/tec/TCGenQry
	//*------------------------------------------------------------------------------------------------------------------------

	Count TO nTotReg //? "Count" cont�m a quantidade de registros da consulta. "Count TO nTotRec" passa a quant. p/ nTot

	//? Define o n�mero m�ximo para a barra de progress�o
	oReport:SetMeter(nTotReg)

	//? Define o t�tulo do Relat�rio
	oReport:SetTitle('Relat�rio de Clientes')

	//? Inicializa uma nova p�gina para impress�o
	oReport:StartPage()

	oSection1:Init()  
	(cAlias)->(DBGoTop())
	
	//? Percorre todos os registros
	while !(cAlias)->(EoF())
		//? Se cancelar a opera��o
		if oReport:Cancel() //! Cancela o loop, ou seja, o processo.
			Exit
		endif

		//? Setando o conte�do do registro posicionado na coluna "C�digo" da se��o
		oSection1:Cell('Codigo'):SetValue((cAlias)->A1_COD)

		//? Setando o conte�do do registro posicionado na coluna "Nome" da se��o
		oSection1:Cell('Nome'):SetValue((cAlias)->A1_NOME)
		
		//? Setando o conte�do do registro posicionado na coluna "Endere�o" da se��o
		oSection1:Cell('Endereco'):SetValue((cAlias)->A1_END)
		
		//? Setando o conte�do do registro posicionado na coluna "Bairro" da se��o
		oSection1:Cell('Bairro'):SetValue((cAlias)->A1_BAIRRO)
		
		//? Setando o conte�do do registro posicionado na coluna "Cidade" da se��o
		oSection1:Cell('Cidade'):SetValue((cAlias)->A1_MUN)
		
		//? Setando o conte�do do registro posicionado na coluna "UF" da se��o
		oSection1:Cell('UF'):SetValue((cAlias)->A1_EST)
		
		//? Setando o conte�do do registro posicionado na coluna "Cep" da se��o
		oSection1:Cell('CEP'):SetValue((cAlias)->A1_CEP)

		//? Imprimindo (gerando) a linha
		oSection1:PrintLine()

		//? Imprimindo uma linha fina
		oReport:ThinLine()

		//? Imcrementando a barra de progress�o
		oReport:IncMeter()

		(cAlias)->(DBSkip())
	enddo   
	
	(cAlias)->(DBCloseArea())

	//? Finalizando a impress�o da se��o
	oSection1:Finish()			

	//? Finalizando a p�gina na impress�o
	oReport:EndPage()
Return  

//* Monta a consuta SQL.
Static Function GeraQuery()
	Local cQuery := ''

	cQuery += 'SELECT A1_COD, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP' + CRLF
	cQuery += 'FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF
Return cQuery
