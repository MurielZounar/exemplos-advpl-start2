#INCLUDE 'TOTVS.CH'

#DEFINE LEFT      1
#DEFINE CENTER    2
#DEFINE RIGHT     3
#DEFINE GERAL     1
#DEFINE NUMERO    2
#DEFINE MONETARIO 3
#DEFINE DATETIME  4

/*/{Protheus.doc} User Function PlanEx
  Exemplo de criação de planilha com a classe FwMsExelEx 
  @type  Function
  @author Muriel Zounar
  @since 12/04/2023
  /*/
User Function PlanEx()
  Local oExcel := FwMsExcelEx():New() //? Instanciando a classe para criação da planilha
  Local cPath  := 'C:\Users\Muriel Zounar\Desktop\' //? Local onde quer salvar o arquivo
  local cArq   := 'Teste_Excel.xls' //? nome do arquivo

  //? Criando nova aba
  oExcel:AddworkSheet('Pessoas')
  
  //? Adicionando nova tabela
  oExcel:AddTable('Pessoas', 'Dados Pessoais')
  
  //? Adicionando colunas
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'Nome'      , LEFT  , GERAL)
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'Sobrenome' , LEFT  , GERAL)
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'Data Nasc.', CENTER, DATETIME)
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'E-mail'    , LEFT  , GERAL)
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'WhatsApp'  , CENTER, GERAL)
  oExcel:AddColumn('Pessoas', 'Dados Pessoais', 'Salário'   , CENTER, MONETARIO)

  //? Alterando estilos da linha 1
  oExcel:SetLineFont('Times New Roman')
  oExcel:SetLineSizeFont(10)
  oExcel:SetLineBgColor('#00FFAA')
  oExcel:SetLineFrColor('#000000')
  
  //? Alterando estilos da linha 2
  oExcel:Set2LineFont('Times New Roman')
  oExcel:Set2LineSizeFont(10)
  oExcel:Set2LineBgColor('#000000')
  oExcel:Set2LineFrColor('#FF0000')

  //? Adicionando linhas com dados em cada coluna
  oExcel:AddRow('Pessoas', 'Dados Pessoais', {'Muriel', 'Zounar', StoD('19940301'), 'muriel.zounar@totvs.com.br', '(11)98123-4567', 22500.50})
  oExcel:AddRow('Pessoas', 'Dados Pessoais', {'Maria', 'Souza', StoD('19790103'), 'maria.souzasou@gmail.com.com.br', '(11)98123-4567', 3567.29})
  oExcel:AddRow('Pessoas', 'Dados Pessoais', {'Gabriel', 'Silva', StoD('19990926'), 'gabr_iel@gmail.com.com.br', '(11)98123-4567', 2533.56})
  oExcel:AddRow('Pessoas', 'Dados Pessoais', {'Helena', 'Rizzo', StoD('19780719'), 'helriz@gmail.com.com.br', '(11)98123-4567', 54998.98})

  //? Criando nova aba
  oExcel:AddworkSheet('Veiculos')
  
  //? Adicionando nova tabela
  oExcel:AddTable('Veiculos', 'Carros no Brasil')
  
  //? Adicionando colunas
  oExcel:AddColumn('Veiculos', 'Carros no Brasil', 'Marca'         , LEFT  , GERAL)
  oExcel:AddColumn('Veiculos', 'Carros no Brasil', 'Modelo'        , LEFT  , GERAL)
  oExcel:AddColumn('Veiculos', 'Carros no Brasil', 'Ano Fabricação', CENTER, NUMERO, .F., '9999')
  oExcel:AddColumn('Veiculos', 'Carros no Brasil', 'Ano Modelo'    , CENTER, NUMERO, .F., '9999')
  oExcel:AddColumn('Veiculos', 'Carros no Brasil', 'Valor Fipe'    , CENTER, MONETARIO)

    //? Adicionando linhas com dados em cada coluna
  oExcel:AddRow('Veiculos', 'Carros no Brasil', {'Hyundai'  , 'HB20 Hatch', 2017, 2017, 50868.00})
  oExcel:AddRow('Veiculos', 'Carros no Brasil', {'Chevrolet', 'Onix'      , 2019, 2020, 64458.00})
  oExcel:AddRow('Veiculos', 'Carros no Brasil', {'Ford'     , 'Ka'        , 2016, 2016, 41450.00})
  oExcel:AddRow('Veiculos', 'Carros no Brasil', {'Volkwagen', 'Gol'       , 2018, 2018, 46852.00})

  //? Alterando estilos do título da planilha
  oExcel:SetTitleFont('Arial Black')
  oExcel:SetTitleSizeFont(14)
  oExcel:SetTitleBold(.T.)
  oExcel:SetTitleBgColor('#FFFF00')
  oExcel:SetTitleFrColor('#000000')

  //? Alterando estilos do cabeçalho das colunas
  oExcel:SetHeaderFont('Arial')
  oExcel:SetHeaderSizeFont(12)
  oExcel:SetHeaderBold(.T.)
  oExcel:SetBgColorHeader('#550099')
  oExcel:SetFrColorHeader('#FFFFFF')

  //? Ativando a classe
  oExcel:Activate()

  //? Gerando arquivo físico
  oExcel:GetXMLFile(cPath + cArq)

  //? Verifica se tem o Excel instalado no PC
  if ApOleClient('MsExcel')
    oExec := MsExcel():New()
    oExec:WorkBooks:Open(cPath + cArq)
    oExec:SetVisible(.T.)
    oExec:Destroy()
  else
    cMsg := 'Microsoft Excel não encontrado!' + CRLF
    cMsg += 'Arquivo salvo em: ' + cPath + cArq
    FwAlertError(cMsg, 'Atenção!')
  endif

  //? Desativando a classe
  oExcel:DeActivate()
Return
