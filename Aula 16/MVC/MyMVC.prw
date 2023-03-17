#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyBrowse
  Exemplo de uso da função FWMBrowse
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cadastro de Cursos'
  Local oBrowse := NIL
  
  //? Criação de um objeto Browse / Instanciamento da Casse:
  oBrowse := FwMBrowse():New()

  //? Definição de qual tabela será exibida no Browse:
  oBrowse:SetAlias(cAlias)

  //? Definição do título que será exibido no Browse:
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

//? Criação das opções do menu:
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MyMVC' OPERATION 2 ACCESS 0 //? Adiciona o botão visualizar
  ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MyMVC' OPERATION 3 ACCESS 0 //? Adiciona o botão incluir
  ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MyMVC' OPERATION 4 ACCESS 0 //? Adiciona o botão alterar
  ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MyMVC' OPERATION 5 ACCESS 0 //? Adiciona o botão excluir
  ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.MyMVC' OPERATION 8 ACCESS 0 //? Adiciona o botão imprimir
  ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.MyMVC' OPERATION 9 ACCESS 0 //? Adiciona o botão copiar
Return aRotina

//? Modelo de Dados
Static Function ModelDef()
  Local oModel // Modelo de dados que será construído
  Local oStruZZC := FWFormStruct(1, 'ZZC') // Cria a estrutura a ser usada no Modelo de Dados

  // Cria o objeto do Modelo de Dados
  oModel := MPFormModel():New('MYMVCM')
  
  // Adiciona ao modelo um componente de formulário
  oModel:AddFields('ZZCMASTER', /*cOwner*/, oStruZZC)
  
  // Adiciona a descrição do Modelo de Dados
  oModel:SetDescription('Modelo de dados de Cursos')
  
  // Adiciona a descrição do Componente do Modelo de Dados
  oModel:GetModel('ZZCMASTER'):SetDescription('Dados do Curso')

  // Define a chave primária
  oModel:SetPrimaryKey({'ZZC_COD'})
Return oModel // Retorna o Modelo de dados

//? Interface
Static Function ViewDef()
  Local oModel   := FWLoadModel('MYMVC') // Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
  Local oStruZZC := FWFormStruct(2, 'ZZC') // Cria a estrutura a ser usada na View
  Local oView // Interface de visualização construída
  
  // Cria o objeto de View
  oView := FWFormView():New()
  
  // Define qual o Modelo de dados será utilizado na View
  oView:SetModel(oModel)
  
  // Adiciona no nosso View um controle do tipo formulário
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')

  // Criar um "box" horizontal para receber o a view
  oView:CreateHorizontalBox('TELA' , 100)
  
  // Relaciona o identificador (ID) da View com o "box" para exibição
  oView:SetOwnerView('VIEW_ZZC', 'TELA')
Return oView // Retorna o objeto de View criado
