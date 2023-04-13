#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

//? Cores
#DEFINE PRETO    RGB(000, 000, 000)
#DEFINE VERMELHO RGB(255, 000, 000)

#DEFINE PAD_RIGHT 1
#DEFINE MAX_LINE  770
 
/*/{Protheus.doc} User Function FwMsPrinter
    Exemplo de relat�rio utilizando FwMSPrinter
    @type  Function
    @author Muriel Zounar
    @since 31/03/2023
/*/
User Function MSPrinter()
    Local cAlias := GeraCons()

    if !Empty(cAlias)
        //? R�gua ed processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relat�rio...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Aten��o')
    endif
Return

//? Fun��o que gera e executa a consulta no BD.
Static Function GeraCons()
    Local aArea  := GetArea()
    Local cAlias := GetNextAlias()
    Local cQuery := ''
    
    cQuery += 'SELECT A1_COD, A1_NOME, A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP, A1_MSBLQL' + CRLF
	cQuery += 'FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
	cQuery += "WHERE D_E_L_E_T_= ' '" + CRLF

    TCQUERY cQuery ALIAS (cAlias) NEW

    (cAlias)->(DbGoTop())

    if (cAlias)->(EOF())
       cAlias := '' 
    endif
    
    RestArea(aArea)
Return cAlias

//? Fun��o principal (Cria��o do Relat�rio)
Static Function MontaRel(cAlias)
    Local cCamPDF    := 'C:\Users\Muriel Zounar\Desktop\'
    Local cArqPDF    := 'CadCli.pdf'
    // Local cArqReport := 'Relatorio_FwMsPrinter'
    //? Local aFonts:= GetFontList() - A fun��o GetFontList retorna um array com todos os nomes de ontes dispon�veis. Obs: Nem todas funcionar�o corretamente no Protheus.
    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private nColIni  := 020
    Private nColFim  := 820
    Private oPrint

    //? Criando padr�es de fontes
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*It�lico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*It�lico*/)

    //? Criando objeto de impress�o
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)

    oPrint:cPathPDF := cCamPDF

    //? Inicializando p�gina de configura��o da impress�o.
    // oPrint:Setup()

    //? Definindo que a orienta��o da p�gina ser� "Retrato"
    oPrint:SetPortrait()

    //? Definindo o tamanho da impress�o como A4
    oPrint:setPaperSize(9)

    //? Criando nova P�gina
    oPrint:StartPage()

    //? Imprime o cabe�alho
    Cabecalho()
    ImpDados(cAlias)

    //? finalizamdo a impress�o
    oPrint:endPage()

    //? Mostrando o relat�rio
    oPrint:Preview()
Return

//? Fun��o para imprimir o cabe�alho
Static Function Cabecalho(cAlias)
    Local cLogo := ('\system\LGRL' + SM0->M0_CODIGO + '.png') //? Para que o logo seja impresso, � necess�rio coloc�-lo na pasta system (dentro da protheus_data).

    //? Criando caixa para colocar texto
    oPrint:Box(15, 15, 85, 580, '-8')

    //? Adicionando uma linha horizontal
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')

    oPrint:SayBitMap(20, 20, cLogo, 70, 65)

    //? Adicionando uma linha vertical
    oPrint:Line(15, 100, 85, 100)

    //? Imprimindo texto do cabe�alho
    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Clientes', oFont16,, PRETO)
    
    //? Imprimindo T�tulo das colunas
    oPrint:Say(nLinha, 20, 'C�DIGO',    oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'NOME',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 200, 'ENDERE�O', oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 320, 'BAIRRO',   oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 400, 'CIDADE',   oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 485, 'UF',       oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 545, 'CEP',      oFont12, /*Width*/, PRETO)
    
    nLinha += 5

    //? Adicionando uma linha horizontal
    oPrint:Line(nLinha, 015, nLinha, 580, /*Cor*/, '-6')

    nLinha += 20 
Return

Static Function ImpDados(cAlias)
    Local cString  := ''
    Private nCor   := 0
    
    DbSelectArea(cAlias)

    (cAlias)->(DbGoTop())

    while (cAlias)->(!EOF())
        if AllTrim((cAlias)->((A1_MSBLQL))) == '1'
            nCor := VERMELHO
        else
            nCor := PRETO
        endif

        //? Imprimindo C�DIGO DO CLIENTE
        oPrint:Say(nLinha, 020, AllTrim((cAlias)->(A1_COD)), oFont10,, nCor)

        //? Copiando o NOME DO CLIENTE para a vari�vel cString
        cString  := AllTrim((cAlias)->(A1_NOME))

        //? Chamando fun��o que verifica se h� a necessidade de quebrar a linha
        VeriQuebLn(cString, 20, 80)

        //? Copiando o ENDERE�O para a vari�vel cString
        cString  := AllTrim((cAlias)->(A1_END))
        VeriQuebLn(cString, 20, 200)

        //? Copiando o BAIRRO para a vari�vel cString
        cString  := AllTrim((cAlias)->(A1_BAIRRO))
        VeriQuebLn(cString, 20, 320)

        //? Copiando a CIDADE para a vari�vel cString
        cString  := AllTrim((cAlias)->(A1_MUN))
        VeriQuebLn(cString, 20, 400)

        //? Imprimindo UF
        oPrint:Say(nLinha, 485, AllTrim((cAlias)->(A1_EST)), oFont10,, nCor)
        
        //? Imprimindo CEP
        oPrint:Say(nLinha, 540, AllTrim((cAlias)->(A1_CEP)), oFont10,, nCor)
        
        //? Aumentando em 30 a posi��o da linha.
        nLinha += 30

        //? Verificando se atingiu o n�mero m�ximo de linhas para uma p�gina (770)
        VeriQuebPg(MAX_LINE)

        (cALias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())
Return

//? Fun��o para fazer quebra de Linha
//? Par�metros: 1 - String que ser� verificada, 2 - Quantidade de caracteres por linha, 3 - Coluna em que o texto ser� impresso 
Static Function VeriQuebLn(cString, nLineTam, nCol)
    Local cLinha   := ''
    Local lTemQbra := .F.
    Local nQtdLine := MLCount(cString, nLineTam, /*Tab. Size*/, .F.) //? Conta quantas linhas s�o necess�rias para escrever o texto com baso no tamanho de linha estipulado em "nLineTam"
    Local nI       := 1

    if nQtdLine > 1
        lTemQbra := .T.
        for nI := 1 to nQtdLine
            //? A fun��o MemoLine copia a quantidade de caracteres de acordo com o tamanho definido em "nLineTam" e atribui o valor em "cLinha", fazendo isso para cada linha.
            //? Obs: A quantidade de linhas necess�rias foi definida pela fun��o MLCount
            cLinha := MemoLine(cString, nLineTam, nI) 
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, nCor)
            //? Aumentando em 10 a posi��o da linha.
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, nCor)
    endif

    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return

//? Fun��o para fazer a quebra de p�gina
Static Function VeriQuebPg(nMax)
    if nLinha > nMax
        //? Encerrando a p�gina atual
        oPrint:EndPage()

        //? Iniciando uma nova p�gina
        oPrint:StartPage()

        nLinha := 105
        
        //? Imprimindo o cabe�alho
        Cabecalho()
    endif
Return
