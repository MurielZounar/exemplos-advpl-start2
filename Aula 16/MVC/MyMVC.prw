#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyBrowse
  Exemplo de uso da fun��o FWMBrowse
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cadastro de Cursos'
  Local oBrowse := NIL
  
  //? Cria��o de um objeto Browse / Instanciamento da Casse:
  oBrowse := FwMBrowse():New()

  //? Defini��o de qual tabela ser� exibida no Browse:
  oBrowse:SetAlias(cAlias)

  //? Defini��o do t�tulo que ser� exibido no Browse:
  oBrowse:SetDescription(cTitle)

  //? Definindo legendas do Browse:
  oBrowse:AddLegend('ZZC_COD == "000001"', 'BLUE', 'ADVPL')
  oBrowse:AddLegend('ZZC_COD == "000002"', 'YELLOW', 'JavaScript')
  oBrowse:AddLegend('ZZC_COD == "000003"', 'RED', 'Angular')

  //? Desabilitar Detalhes do Browse:
  oBrowse:DisableDetails()

  //? Ativado o Browse:
  oBrowse:Activate()
Return

//? Cria��o das op��es do menu:
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MyMVC' OPERATION 2 ACCESS 0 //? Adiciona o bot�o visualizar
  ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MyMVC' OPERATION 3 ACCESS 0 //? Adiciona o bot�o incluir
  ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MyMVC' OPERATION 4 ACCESS 0 //? Adiciona o bot�o alterar
  ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MyMVC' OPERATION 5 ACCESS 0 //? Adiciona o bot�o excluir
  ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.MyMVC' OPERATION 8 ACCESS 0 //? Adiciona o bot�o imprimir
  ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.MyMVC' OPERATION 9 ACCESS 0 //? Adiciona o bot�o copiar
Return aRotina

//? Modelo de Dados
Static Function ModelDef()
  Local oModel // Modelo de dados que ser� constru�do
  Local oStruZZC := FWFormStruct(1, 'ZZC') // Cria a estrutura a ser usada no Modelo de Dados

  // Cria o objeto do Modelo de Dados
  oModel := MPFormModel():New('MYMVCM')
  
  // Adiciona ao modelo um componente de formul�rio
  oModel:AddFields('ZZCMASTER', /*cOwner*/, oStruZZC)
  
  // Adiciona a descri��o do Modelo de Dados
  oModel:SetDescription('Modelo de dados de Cursos')
  
  // Adiciona a descri��o do Componente do Modelo de Dados
  oModel:GetModel('ZZCMASTER'):SetDescription('Dados do Curso')

  // Define a chave prim�ria
  oModel:SetPrimaryKey({'ZZC_COD'})
Return oModel // Retorna o Modelo de dados

//? Interface
Static Function ViewDef()
  Local oModel   := FWLoadModel('MYMVC') // Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
  Local oStruZZC := FWFormStruct(2, 'ZZC') // Cria a estrutura a ser usada na View
  Local oView // Interface de visualiza��o constru�da
  
  // Cria o objeto de View
  oView := FWFormView():New()
  
  // Define qual o Modelo de dados ser� utilizado na View
  oView:SetModel(oModel)
  
  // Adiciona no nosso View um controle do tipo formul�rio
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')

  // Criar um "box" horizontal para receber o a view
  oView:CreateHorizontalBox('TELA' , 100)
  
  // Relaciona o identificador (ID) da View com o "box" para exibi��o
  oView:SetOwnerView('VIEW_ZZC', 'TELA')
Return oView // Retorna o objeto de View criado
