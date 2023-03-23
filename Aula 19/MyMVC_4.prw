#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyMVC_4
  Exemplo de uso de Eventos da View e Browse com coluna de marca��o
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC_4()
  Local cAlias  := 'ZZC'
  Local cTitle  := 'Cursos de Programa��o'
  Local oMark   := FWMarkBrowse():New() //? Instanciando a Classe
  
  //? Adiconando bot�es (n�o � necessario ter MenuDef)
  oMark:AddButton('Marcar Todos',    'U_Marca',   , 1)
  oMark:AddButton('Desmarcar Todos', 'U_Desmarca',, 1)
  oMark:AddButton('Inverter Marc.',  'U_Inverte', , 1)
  oMark:AddButton('Excluir Marc.',   'U_Deleta', 5, 1)
  
  //? Defini��o da tabela a ser utilizada
  oMark:SetAlias(cAlias)

  //? Define o t�tulo do browse de marca��o
  oMark:SetDescription(cTitle)

  //? Define o campo que ser� utilizado para a marca��o
  oMark:SetFieldMark('ZZC_MARC')

  //? Desabilita os detalhes
  oMark:DisableDetails()

  //? Desabilita o bot�o de impress�o
  oMark:DisableReport()

  //? Ativa��o da classe
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

  //? Com o valor .F., ao clicar em "Confirmar" na inclus�o, a tela de cadatro ser� limpa e permanecer� aberta. Se estiver como .T. a tela de cadastro fecha ap�s a confirma��o do cadastro.
  oView:SetCloseOnOk({|| .F.}) 

  //? Executa a a��o do bloco de c�digo ap�s pressionar o bot�o "Confirmar"
  oView:SetAfterOkButton({|| FwAlertSuccess('Tudo certo!', 'SetAfterOkButton')})

  //? Verifica se a tela pode ser aberta ou n�o.
  oView:SetViewCanActivate({|| MsgYesNo('Ativar a tela?', 'SetViewCanActivate')})

  //? Esse m�todo � executado ap�s a ativa��o da View
  oView:SetAfterViewActivate({|| FwAlertInfo('', 'Tela Ativada!')})
Return oView

//? Fun��o para Marcar todos os registros 
User Function Marca()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if !oMark:IsMark() //? Se n�o estiver marcado
      oMark:MarkRec()  //? Marca o Registro
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualiza��o das informa��es no Browse
  oMark:Refresh(.T.) //? .T. Indica que dever� ser posicionado no primeiro registro do Browse
Return

//? Fun��o para Desmarcar todos os registros 
User Function Desmarca()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if oMark:IsMark() //? Se estiver marcado
      oMark:MarkRec() //? Desarca o Registro
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualiza��o das informa��es no Browse
  oMark:Refresh(.T.) //? .T. Indica que dever� ser posicionado no primeiro registro do Browse
Return

//? Fun��o para inverter marca��o de todos os registros 
User Function Inverte()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    oMark:MarkRec()
    
    ZZC->(DbSkip())
  enddo

  //? Executa a atualiza��o das informa��es no Browse
  oMark:Refresh(.T.) //? .T. Indica que dever� ser posicionado no primeiro registro do Browse
Return

//? Fun��o para deletar registros marcados
User Function Deleta()
  DbSelectArea('ZZC')
  
  ZZC->(DbGotop())
  
  while ZZC->(!EOF())
    if oMark:IsMark()   //? Verifica se o registro est� marcado
      if MsgYesNo('Confirma a exclus�o dos cursos selecionados?')
        RecLock('ZZC', .F.)
          ZZC->(DbDelete()) //? Marca o registro como Deletada (D_E_L_E_T_ = '*')
        ZZC->(MSUnlock())
      endif
    endif

    ZZC->(DbSkip())
  enddo

  //? Executa a atualiza��o das informa��es no Browse
  oMark:Refresh(.T.) //? .T. Indica que dever� ser posicionado no primeiro registro do Browse
Return
