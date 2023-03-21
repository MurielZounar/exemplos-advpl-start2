#INCLUDE 'TOTVS.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function MyBrowse
  Exemplo de usoValida��es utilizando rotina em MVC
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyMVC_3()
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
  oBrowse:DisableReport()

  oBrowse:Activate()
Return

Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MyMVC_3' OPERATION 2 ACCESS 0
  ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MyMVC_3' OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MyMVC_3' OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MyMVC_3' OPERATION 5 ACCESS 0
Return aRotina

Static Function ModelDef()
  Local bModVldActiv := {|oMdl| FwAlertInf('Vamos ao cadastro!', 'Cadastro de Curso'), .T.} //? Bloco de c�digo que ser� chamado na Pr�-valida��o (MODELVLDACTIVE)
  Local bModelPre    := {|oMdl| ValidPre(oMdl)} //? Bloco de c�digo que ser� chamado na Pr�-valida��o (MODELPRE)
  Local bModelPos    := {|oMdl| ValidPos(oMdl)} //? Bloco de c�digo que ser� chamado na P�s-valida��o (MODELPOS)
  Local bModelCancel := {|oMdl| Cancel(oMdl)}   //? Bloco de c�digo que ser� chamado na P�s-valida��o (MODELCANCEL)
  Local bFieldPos    := {|oFld| ValidField(oFld)}
  // Local bLoad        := {|oFld, lCopy| LoadFields(oFld, lCopy)}
  Local bLinePre     := {|oGrid, nLine, cAction, cFieldId, xValue, xCurValue| ValidLine(oGrid, nLine, cAction, cFieldId, xValue, xCurValue)}
  Local bLinePost    := {|oGrid, nLine| ValidPosLine(oGrid, nLine)}
  Local bLineLoad    := {|oGrid, lCopy| LoadLine(oGrid, lCopy)}
  Local oModel       := MPFormModel():New('MYMVC_3M', bModelPre, bModelPos, /*MODELCOMITTTS*/, bModelCancel)
  Local oStruZZC     := FWFormStruct(1, 'ZZC')
  Local oStruZZB     := FWFormStruct(1, 'ZZB')
  Local aTrig        := FwStruTrigger('ZZB_COD',;       
                                  'ZZB_NOME',;      
                                  'ZZA->ZZA_NOME',; 
                                  .T.,;             
                                  'ZZA',;           
                                  1,;               
                                  'xFilial("ZZB")+Alltrim(M->ZZB_COD)')
  
  oStruZZB:AddTrigger(aTrig[1],aTrig[2],aTrig[3],aTrig[4])

  oModel:AddFields('ZZCMASTER', /*cOwner*/, oStruZZC, /*bPre*/, bFieldPos, /*bLoad*/)
  oModel:AddGrid('ZZBDETAIL', 'ZZCMASTER', oStruZZB, bLinePre, bLinePost, /*bPre*/, /*bPost*/, bLineLoad) 
  oModel:SetRelation('ZZBDETAIL', {{'ZZB_FILIAL', 'xFilial("ZZB")'},{'ZZB_CURSO', 'ZZC_COD'}}, ZZB->(IndexKey(1)))
  oModel:SetDescription('Modelo de dados de Cursos')
  oModel:GetModel('ZZCMASTER'):SetDescription('Curso')
  oModel:GetModel('ZZBDETAIL'):SetDescription('Alunos')
  oModel:SetPrimaryKey({'ZZC_COD', 'ZZB_COD'})

  //? Definindo que o campo ZZB_COD n�o pode se repetir na grade.
  oModel:GetModel('ZZBDETAIL'):SetUniqueLine({'ZZB_COD'})

  //? Adicionando valida��o na inicializa��o do modelo (MODELVLDACTIVE)
  oModel:SetVldActivate(bModVldActiv)
Return oModel

Static Function ViewDef()
  Local oModel   := FWLoadModel('MYMVC_3') 
  Local oStruZZC := FWFormStruct(2, 'ZZC' ) //? Pegando a estrutura da 1� tabela (Fields)
  Local oStruZZB := FWFormStruct(2, 'ZZB' ) //? Pegando a estrutura da 2� tabela (Grid)
  Local oView
  
  oView := FWFormView():New()
  oView:SetModel(oModel)
  oView:AddField('VIEW_ZZC', oStruZZC, 'ZZCMASTER')
  oView:AddGrid('VIEW_ZZB', oStruZZB, 'ZZBDETAIL')
  oView:CreateHorizontalBox('CURSO' , 40)
  oView:CreateHorizontalBox('ALUNOS' , 60)
  oView:SetOwnerView('VIEW_ZZC', 'CURSO') //* VIEW_ZZC � o nome que foi definido na linha 73
  oView:SetOwnerView('VIEW_ZZB', 'ALUNOS') //* VIEW_ZZB � o nome que foi definido na linha 76
  oView:EnableTitleView('VIEW_ZZB', 'Alunos')
Return oView

//? Fun��o chamada pela pr� valida��o do Model
Static Function ValidPre(oMdl)
  Local nOperation  := oMdl:GetOperation()
  Local lAutorizado := .T.

  if nOperation == 4 //? Altera��o
    oMdl:GetModel('ZZCMASTER'):GetStruct():SetProperty('ZZC_COD', MODEL_FIELD_WHEN, FwBuildFeature(STRUCT_FEATURE_WHEN, '.F.'))
    lAutorizado := .F.
  endif
Return lAutorizado

//? Fun��o chamada pela pr� valida��o do Model
Static Function ValidPos(oMdl)
  Local nOperation  := oMdl:GetOperation()
  Local cConteudo   := oMdl:GetValue('ZZCMASTER', 'ZZC_NOME') //? Pega o conte�do do campo "NOME" da tabela "ZZC" (CURSOS)
  Local lPreenchido := !Empty(cConteudo) //? Verifica se o campo est� vazio.
  Local lTudoOk     := .T.
  
  if nOperation == 5 //! Exclus�o
    Help(NIL, NIL, 'N�o autorizado', NIL, 'Voc� n�o tem autoriza��o para fazer exclus�es!', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Contate o administrador!'})
    lTudoOk := .F.
  elseif !lPreenchido
    Help(NIL, NIL, 'N�o � poss�vel gravar o curso', NIL, 'O <b>Nome do Curso</b> n�o foi preenchido!', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o <b>Nome do Curso</b>!'})
    lTudoOk := .F.
  endif
Return lTudoOk

//? Fun��o chamada quando o usu�rio cancela a opera��o 
Static Function Cancel(oMdl)
  Local lCancela := .F.
  Local cMsg     := 'Deseja cancelar a opera��o?'
  
  FwFormCancel(oMdl)
  lCancela := MsgYesNo(cMsg, 'Cancelar?')
Return lCancela

//? P�s Valida��o dos Fields
Static Function ValidField(oFld)
  Local lTudoOk := .T.
  Local cCod    := oFld:GetValue('ZZC_COD') 

  if cCod == '000000'
    Help(NIL, NIL, 'Opera��o n�o permitida', NIL, 'O c�digo do curso n�o pode ser <b>000000</b>!', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Preencha o <b>C�digo do curso</b> corretamente!'})
    lTudoOk := .F.
  endif
Return lTudoOk

//? Load dos Fields 
Static Function LoadFields(oFld, lCopy)
  Local aDados := {}
  Local nRec   := LASTREC() 

  Aadd(aDados, {xFilial('ZZC'), '000008', 'SQL'})
  Aadd(aDados, nRec)
Return aDados

//? valida��o pr� linha
Static Function ValidLine(oGrid, nLine, cAction, cFieldId, xValue, xCurValue)
  Local lValido := .T.

  if cFieldId == 'ZZB_COD' .AND. cAction == 'SETVALUE' .AND. xValue == xCurValue
    Help(NIL, NIL, 'N�o tem por que fazer isso', NIL, 'Voc� digitou o mesmo c�digo!', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Digite outra coisa!'})
    lValido := .F.
  endif
Return lValido

//? Valida��o p�s linha
Static Function ValidPosLine(oGrid, nLine)
  Local lValido := .T.
  Local cAluno  := AllTrim(UPPER(oGrid:GetValue('ZZB_NOME')))

  if cAluno == 'MURIEL'
    Help(NIL, NIL, 'Aluno proibido', NIL, 'O aluno Muriel est� proibido de estudar aqui!', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Selecione outro aluno!'})
    lValido := .F.
  endif
Return lValido

//? Load de linha do grid
Static Function LoadLine(oGrid, lCopy)
  Local aRetorno := {}
  Local aFields  := oGrid:GetStruct():GetFields() //? Carrega a estrutura de campos do grid
  Local aAux     := Array(Len(aFields)) 
  Local nI       := 0

  for nI := 1 to Len(aFields)
    if AllTrim(aFields[nI][3]) == 'ZZB_DTINIC'
      aAux[nI] := Date()
    endif
  next

  Aadd(aRetorno, {0, aAux})
Return aRetorno
