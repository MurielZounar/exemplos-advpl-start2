#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyBrowse
  Exemplo de fonte em MVC
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC_2()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cursos'
  Local oBrowse := NIL
  
  oBrowse := FwMBrowse():New()
  oBrowse:SetAlias(cAlias)
  oBrowse:SetDescription(cTitle)
  oBrowse:AddLegend('ZZC_COD == "000001"', 'BLUE', 'ADVPL')
  oBrowse:AddLegend('ZZC_COD == "000002"', 'YELLOW', 'JavaScript')
  oBrowse:AddLegend('ZZC_COD == "000003"', 'RED', 'Angular')
  oBrowse:DisableDetails() 
  oBrowse:DisableReport() //? Desabilida o bot�o "Imprimir"

  oBrowse:Activate()
Return

Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MyMVC_2' OPERATION 2 ACCESS 0
  ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MyMVC_2' OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MyMVC_2' OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MyMVC_2' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()
  Local oModel   := MPFormModel():New('MYMVC_2M')
  Local oStruZZC := FWFormStruct(1, 'ZZC') //? Pegando a estrutura da 1� tabela (Fields)
  Local oStruZZB := FWFormStruct(1, 'ZZB') //? Pegando a estrutura da 2� tabela (Grid)
  Local aTrig    := FwStruTrigger('ZZB_COD',;       //? Campo Dom�nio
                                  'ZZB_NOME',;      //? Campo de Contra-dom�nio
                                  'ZZA->ZZA_NOME',; //? Regra de preenchimento
                                  .T.,;             //? lSeek: Se posicionar ou no antes da execuo do gatilhos
                                  'ZZA',;           //? Alias da tabela a ser posicionada
                                  1,;               //? Ordem da tabela a ser posicionada
                                  'xFilial("ZZA")+Alltrim(M->ZZB_COD)') //? Chave de busca da tabela a ser posicionada
  
  //? Adiciona a Trigger � estrutura
  oStruZZB:AddTrigger(aTrig[1],aTrig[2],aTrig[3],aTrig[4])

  //? Criando modelo de dados dos campos do Form
  oModel:AddFields('ZZCMASTER', /*cOwner*/, oStruZZC)

  //? Criando modelo de dados do Grid
  oModel:AddGrid('ZZBDETAIL', 'ZZCMASTER', oStruZZB) 

  //? Relacionando a tabela do grid (ZZB)(filha) com a tabela dos fields (ZZC)(pai)
  oModel:SetRelation('ZZBDETAIL', {{'ZZB_FILIAL', 'xFilial("ZZB")'},{'ZZB_CURSO', 'ZZC_COD'}}, ZZB->(IndexKey(1)))
  
  //? Descri��o geral do modelo:
  oModel:SetDescription('Modelo de dados de Cursos')

  //? Descri��o geral do modelo:
  oModel:GetModel('ZZCMASTER'):SetDescription('Curso')

  //? Descri��o geral do modelo:
  oModel:GetModel('ZZBDETAIL'):SetDescription('Alunos')

  //? Definindo chave prim�ria
  oModel:SetPrimaryKey({'ZZC_COD', 'ZZB_COD'})
Return oModel

Static Function ViewDef()
  Local oModel   := FWLoadModel('MYMVC_2') 
  Local oStruZZC := FWFormStruct(2, 'ZZC' ) //? Pegando a estrutura da 1� tabela (Fields)
  Local oStruZZB := FWFormStruct(2, 'ZZB' ) //? Pegando a estrutura da 2� tabela (Grid)
  Local oView    := FWFormView():New()
  
  oView:SetModel(oModel)

  //? Criando Form:
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')

  //? Criano Grid:
  oView:AddGrid('VIEW_ZZB', oStruZZB, 'ZZBDETAIL')

  //? Definindo nome do 1� componente visual (tela/painel/caixa) horizontal e o percentual da tela que ele ocupar�:
  oView:CreateHorizontalBox('CURSO' , 40)

  //? Definindo nome do 2� componente visual (tela/painel/caixa) horizontal e o percentual da tela que ele ocupar�:
  oView:CreateHorizontalBox('ALUNOS' , 60)

  //? � mais ou menos assim que a tela vai ficar:
  //*|-------------------------------------------|
  //*|                                           |
  //*|             DADOS DO CURSO                |
  //*|                                           |
  //*|___________________________________________|
  //*|                                           |
  //*|                                           |
  //*|            DADOS DOS ALUNOS               |
  //*|                                           |
  //*|                                           |
  //*|                                           |
  //*|-------------------------------------------|
  
  //? Definindo que os dados do curso aparecer�o na primeiro componente ('CURSO'):
  oView:SetOwnerView('VIEW_ZZC', 'CURSO') //* VIEW_ZZC � o nome que foi definido na linha 82

  //? Definindo que os dados dos alunos (grid) aparecer�o na segundo componente ('ALUNOS'):
  oView:SetOwnerView('VIEW_ZZB', 'ALUNOS') //* VIEW_ZZB � o nome que foi definido na linha 85

  //? Definindo um t�tulo para o grid:
  oView:EnableTitleView('VIEW_ZZB', 'Alunos')

  //? A��o de Interface:
  oView:SetViewAction('BUTTONOK', {|oView| MostraMsg(oView)}) //* Ser� executada ao clicar em "Confirmar"

  //? A��o de Campo:
  oView:SetFieldAction('ZZC_COD', {|oView, cIDView, cField, xValue| CarregaNome(oView, cIDView, cField, xValue)}) //* Ser� executado ao tirar o foco do campo "ZZC_COD"
  
  //? Adicionando um bot�o � tela: 
  oView:AddUserButton('Bot�o Maneiro', 'CLIPS', {|| MsgManeira()}, 'Bot�o para exibir "Mensagem Maneira"', /*nShortCut*/, {MODEL_OPERATION_INSERT, MODEL_OPERATION_UPDATE})

  //? Adicionando outros objetos:
  oView:AddOtherObjects('BOTAO', {|oPanel| ClickAqui(oPanel)})
  oView:SetOwnerView('BOTAO', 'CURSO')
Return oView

//? Fun��o chamada pelo SetViewAction (Linha 117)
Static Function MostraMsg(oView)
  Local nOper := oView:GetOperation() //? Pegando o n�mero da opera��o
  Local cCurso := oView:GetValue('ZZCMASTER', 'ZZC_NOME') //? Pegando conte�do do campo ZZC_NOME (Nome do Curso)

  if nOper == 3 //* Inclus�o
    FwAlertSuccess('Inclus�o do curso <b>' + cCurso + '</b> realizada com sucesso', 'SetViewAction')
  elseif nOper == 4 //? Altera��o
    FwAlertInfo('Altera��o do curso <b>' + cCurso + '</b> realizada com sucesso', 'SetViewAction')
  elseif nOper == 5 //! Exclus�o
    FwAlertError('Exclus�o do curso <b>' + cCurso + '</b> realizada com sucesso', 'SetViewAction')
  endif 
Return

//? Fun��o chamada pelo SetFielAction (Linha 120)
Static Function CarregaNome(oView, cIDView, cField, xValue)
  Local cText := 'CURSO'
  Local oModel := oView:GetModel('ZZCMASTER') //? Pegando o modelo
  
  //? Setando (aplicando) o valor de cText no campo ZZC_NOME:
  oModel:SetValue('ZZC_NOME', cText) 
  
  //? Atualizando a Tela:
  oView:Refresh()
Return

//? Fun��o chamada pelo AddUserButton (Linha 123)
Static Function MsgManeira()
  FwAlertSuccess('Pronto!', 'Mensagem Maneira')
Return

//? Fun��o chamada pelo AddOtherObjects (Linha 126)
Static Function ClickAqui(oPanel)
  //? Criando bot�o
  TButton():New(005, 001, 'Clique Aqui', oPanel, {|| FwAlertSuccess('Voc� clicou!', 'Parab�ns!')}, 050, 020) 
Return
