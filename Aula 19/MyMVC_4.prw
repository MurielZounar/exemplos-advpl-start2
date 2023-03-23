#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyMVC_4
  Exemplo de uso de Eventos da View e Browse com coluna de marcação
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC_4()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cursos de Programação'
  Local oMark   := FWMarkBrowse():New() //? Instanciando a Classe
  
  //? Adiconando botões (não é necessario ter MenuDef)
  oMark:AddButton('Marcar Todos',    'U_Marca',   , 1)
  oMark:AddButton('Desmarcar Todos', 'U_Desmarca',, 1)
  oMark:AddButton('Inverter Marc.',  'U_Inverte', , 1)
  oMark:AddButton('Excluir Marc.',   'U_Deleta', 5, 1)
  
  //? Definição da tabela a ser utilizada
  oMark:SetAlias(cAlias)

  //? Define o título do browse de marcação
  oMark:SetDescription(cTitle)

  //? Define o campo que será utilizado para a marcação
  oMark:SetFieldMark('ZZC_MARC')

  //? Desabilita os detalhes
  oMark:DisableDetails()

  //? Desabilita o botão de impressão
  oMark:DisableReport()

  //? Ativação da classe
  oMark:Activate()
Return

// Static Function MenuDef()
//   Local aRotina := {}

//   ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MyMVC_4' OPERATION 2 ACCESS 0
//   ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MyMVC_4' OPERATION 3 ACCESS 0
//   ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MyMVC_4' OPERATION 4 ACCESS 0
//   ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MyMVC_4' OPERATION 5 ACCESS 0
// Return aRotina

Static Function ModelDef()
  Local oModel       := MPFormModel():New('MYMVC_4M')
  Local oStruZZC     := FWFormStruct(1, 'ZZC')
  Local oStruZZB     := FWFormStruct(1, 'ZZB')
  Local aTrig        := FwStruTrigger('ZZB_COD', 'ZZB_NOME', 'ZZA->ZZA_NOME', .T., 'ZZA', 1, 'xFilial("ZZB")+Alltrim(M->ZZB_COD)')
  
  oStruZZB:AddTrigger(aTrig[1],aTrig[2],aTrig[3],aTrig[4])

  oModel:AddFields('ZZCMASTER', /*cOwner*/, oStruZZC)
  oModel:AddGrid('ZZBDETAIL', 'ZZCMASTER', oStruZZB)
  oModel:SetRelation('ZZBDETAIL', {{'ZZB_FILIAL', 'xFilial("ZZB")'},{'ZZB_CURSO', 'ZZC_COD'}}, ZZB->(IndexKey(1)))
  oModel:SetDescription('Modelo de dados de Cursos')
  oModel:GetModel('ZZCMASTER'):SetDescription('Curso')
  oModel:GetModel('ZZBDETAIL'):SetDescription('Alunos')
  oModel:SetPrimaryKey({'ZZC_COD', 'ZZB_COD'})
  oModel:GetModel('ZZBDETAIL'):SetUniqueLine({'ZZB_COD'})
Return oModel

Static Function ViewDef()
  Local oModel   := FWLoadModel('MYMVC_4') 
  Local oStruZZC := FWFormStruct(2, 'ZZC' )
  Local oStruZZB := FWFormStruct(2, 'ZZB' )
  Local oView
  
  oView := FWFormView():New()
  oView:SetModel(oModel)
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')
  oView:AddGrid('VIEW_ZZB', oStruZZB, 'ZZBDETAIL')
  oView:CreateHorizontalBox('CURSO' , 40)
  oView:CreateHorizontalBox('ALUNOS' , 60)
  oView:SetOwnerView('VIEW_ZZC', 'CURSO')
  oView:SetOwnerView('VIEW_ZZB', 'ALUNOS')
  oView:EnableTitleView('VIEW_ZZB', 'Alunos')

  //? Com o valor .F., ao clicar em "Confirmar" na inclusão, a tela de cadatro será limpa e permanecerá aberta. Se estiver como .T. a tela de cadastro fecha após a confirmação do cadastro.
  oView:SetCloseOnOk({|| .F.}) 

  //? Executa a ação do bloco de código após pressionar o botão "Confirmar"
  oView:SetAfterOkButton({|| FwAlertSuccess('Tudo certo!', 'SetAfterOkButton')})

  //? Verifica se a tela pode ser aberta ou não.
  oView:SetViewCanActivate({|| MsgYesNo('Ativar a tela?', 'SetViewCanActivate')})

  //? Esse método é executado após a ativação da View
  oView:SetAfterViewActivate({|| FwAlertInfo('', 'Tela Ativada!')})
Return oView

//? Função para Marcar todos os registros 
User Function Marca()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if !oMark:IsMark() //? Se não estiver marcado
      oMark:MarkRec()  //? Marca o Registro
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualização das informações no Browse
  oMark:Refresh(.T.) //? .T. Indica que deverá ser posicionado no primeiro registro do Browse
Return

//? Função para Desmarcar todos os registros 
User Function Desmarca()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if oMark:IsMark() //? Se estiver marcado
      oMark:MarkRec() //? Desarca o Registro
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualização das informações no Browse
  oMark:Refresh(.T.) //? .T. Indica que deverá ser posicionado no primeiro registro do Browse
Return

//? Função para inverter marcação de todos os registros 
User Function Inverte()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    oMark:MarkRec()
    
    ZZC->(DbSkip())
  enddo

  //? Executa a atualização das informações no Browse
  oMark:Refresh(.T.) //? .T. Indica que deverá ser posicionado no primeiro registro do Browse
Return

//? Função para deletar registros marcados
User Function Deleta()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if oMark:IsMark()   //? Verifica se o registro está marcado
      if MsgYesNo('Confirma a exclusão dos cursos selecionados?')
        RecLock('ZZC', .F.)
          ZZC->(DbDelete()) //? Marca o registro como Deletada (D_E_L_E_T_ = '*')
        ZZC->(MSUnlock())
      endif
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualização das informações no Browse
  oMark:Refresh(.T.) //? .T. Indica que deverá ser posicionado no primeiro registro do Browse
Return
