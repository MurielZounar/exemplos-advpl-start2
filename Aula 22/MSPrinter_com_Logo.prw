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
    Exemplo de relatório utilizando FwMSPrinter
    @type  Function
    @author Muriel Zounar
    @since 31/03/2023
/*/
User Function MSPrinter()
    Local cAlias := GeraCons()

    if !Empty(cAlias)
        //? Régua ed processamento
	    Processa({|| MontaRel(cAlias)}, 'Aguarde...', 'Imprimindo relatório...', .F.)
    else    
        FwAlertError('Nenhum Registro encontrado!', 'Atenção')
    endif
Return

//? Função que gera e executa a consulta no BD.
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

//? Função principal (Criação do Relatório)
Static Function MontaRel(cAlias)
    Local cCamPDF    := 'C:\Users\Muriel Zounar\Desktop\'
    Local cArqPDF    := 'CadCli.pdf'
    // Local cArqReport := 'Relatorio_FwMsPrinter'
    //? Local aFonts:= GetFontList() - A função GetFontList retorna um array com todos os nomes de ontes disponíveis. Obs: Nem todas funcionarão corretamente no Protheus.
    Private dDataGer := Date()
    Private cHoraGer := Time()
    Private nLinha   := 105
    Private nColIni  := 020
    Private nColFim  := 820
    Private oPrint

    //? Criando padrões de fontes
    Private oFont08  := TFont():New('Arial',/*Compat.*/, 08 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont10  := TFont():New('Arial',/*Compat.*/, 10 /*Tamanho*/, /*Compat.*/, .F. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont12  := TFont():New('Arial',/*Compat.*/, 12 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont14  := TFont():New('Arial',/*Compat.*/, 14 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .F./*Sublinhado*/, .F./*Itálico*/)
    Private oFont16  := TFont():New('Arial',/*Compat.*/, 16 /*Tamanho*/, /*Compat.*/, .T. /*Negrito*/,/*Compat.*/,/*Compat.*/,/*Compat.*/,/*Compat.*/, .T./*Sublinhado*/, .F./*Itálico*/)

    //? Criando objeto de impressão
    oPrint := FWMSPrinter():New(cArqPDF, IMP_PDF, .F., '', .T.,, @oPrint, '',,,, .T.)

    oPrint:cPathPDF := cCamPDF

    //? Inicializando página de configuração da impressão.
    // oPrint:Setup()

    //? Definindo que a orientação da página será "Retrato"
    oPrint:SetPortrait()

    //? Definindo o tamanho da impressão como A4
    oPrint:setPaperSize(9)

    //? Criando nova Página
    oPrint:StartPage()

    //? Imprime o cabeçalho
    Cabecalho()
    ImpDados(cAlias)

    //? finalizamdo a impressão
    oPrint:endPage()

    //? Mostrando o relatório
    oPrint:Preview()
Return

//? Função para imprimir o cabeçalho
Static Function Cabecalho(cAlias)
    Local cLogo := ('\system\LGRL' + SM0->M0_CODIGO + '.png') //? Para que o logo seja impresso, é necessário colocá-lo na pasta system (dentro da protheus_data).

    //? Criando caixa para colocar texto
    oPrint:Box(15, 15, 85, 580, '-8')

    //? Adicionando uma linha horizontal
    oPrint:Line(50, 100, 50, 580, /*Cor*/, '-6')

    oPrint:SayBitMap(20, 20, cLogo, 70, 65)

    //? Adicionando uma linha vertical
    oPrint:Line(15, 100, 85, 100)

    //? Imprimindo texto do cabeçalho
    oPrint:Say(35, 110, 'Empresa / Filial: ' + AllTrim(SM0->M0_NOME) + ' / ' + AllTrim(SM0->M0_FILIAL), oFont14,, PRETO)
    oPrint:Say(70, 280, 'Cadastro de Clientes', oFont16,, PRETO)
    
    //? Imprimindo Título das colunas
    oPrint:Say(nLinha, 20, 'CÓDIGO',    oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 80,  'NOME',     oFont12, /*Width*/, PRETO)
    oPrint:Say(nLinha, 200, 'ENDEREÇO', oFont12, /*Width*/, PRETO)
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

        //? Imprimindo CÓDIGO DO CLIENTE
        oPrint:Say(nLinha, 020, AllTrim((cAlias)->(A1_COD)), oFont10,, nCor)

        //? Copiando o NOME DO CLIENTE para a variável cString
        cString  := AllTrim((cAlias)->(A1_NOME))

        //? Chamando função que verifica se há a necessidade de quebrar a linha
        VeriQuebLn(cString, 20, 80)

        //? Copiando o ENDEREÇO para a variável cString
        cString  := AllTrim((cAlias)->(A1_END))
        VeriQuebLn(cString, 20, 200)

        //? Copiando o BAIRRO para a variável cString
        cString  := AllTrim((cAlias)->(A1_BAIRRO))
        VeriQuebLn(cString, 20, 320)

        //? Copiando a CIDADE para a variável cString
        cString  := AllTrim((cAlias)->(A1_MUN))
        VeriQuebLn(cString, 20, 400)

        //? Imprimindo UF
        oPrint:Say(nLinha, 485, AllTrim((cAlias)->(A1_EST)), oFont10,, nCor)
        
        //? Imprimindo CEP
        oPrint:Say(nLinha, 540, AllTrim((cAlias)->(A1_CEP)), oFont10,, nCor)
        
        //? Aumentando em 30 a posição da linha.
        nLinha += 30

        //? Verificando se atingiu o número máximo de linhas para uma página (770)
        VeriQuebPg(MAX_LINE)

        (cALias)->(DbSkip())
    enddo

    (cAlias)->(DbCloseArea())
Return

//? Função para fazer quebra de Linha
//? Parâmetros: 1 - String que será verificada, 2 - Quantidade de caracteres por linha, 3 - Coluna em que o texto será impresso 
Static Function VeriQuebLn(cString, nLineTam, nCol)
    Local cLinha   := ''
    Local lTemQbra := .F.
    Local nQtdLine := MLCount(cString, nLineTam, /*Tab. Size*/, .F.) //? Conta quantas linhas são necessárias para escrever o texto com baso no tamanho de linha estipulado em "nLineTam"
    Local nI       := 1

    if nQtdLine > 1
        lTemQbra := .T.
        for nI := 1 to nQtdLine
            //? A função MemoLine copia a quantidade de caracteres de acordo com o tamanho definido em "nLineTam" e atribui o valor em "cLinha", fazendo isso para cada linha.
            //? Obs: A quantidade de linhas necessárias foi definida pela função MLCount
            cLinha := MemoLine(cString, nLineTam, nI) 
            oPrint:Say(nLinha, nCol, cLinha, oFont10,, nCor)
            //? Aumentando em 10 a posição da linha.
            nLinha += 10
        next
    else
        oPrint:Say(nLinha, nCol, cString, oFont10,, nCor)
    endif

    if lTemQbra
        nLinha -= nQtdLine * 10 
    endif
Return

//? Função para fazer a quebra de página
Static Function VeriQuebPg(nMax)
    if nLinha > nMax
        //? Encerrando a página atual
        oPrint:EndPage()

        //? Iniciando uma nova página
        oPrint:StartPage()

        nLinha := 105
        
        //? Imprimindo o cabeçalho
        Cabecalho()
    endif
Return
