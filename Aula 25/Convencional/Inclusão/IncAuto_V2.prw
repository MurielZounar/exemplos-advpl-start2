#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function IncAuto
  Inclusão por rotina automática
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function IncAuto()
  Local aCabec := {}
	Local aItens := {}
  Local aLinha := {}
  Local lOk    := .T.
  Local nOper  := 3
  Local nI     := 0
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'FAT'

  DbSelectArea('SB1')
  DbSetOrder(1)

  if !SB1->(MsSeek(xFilial('SB1') + '10'))
    lOk := .F.
  endif

  DbSelectArea('SF4')
  DbSetOrder(1)

  if !SF4->(MsSeek(xFilial('SF4') + '501'))
    lOk := .F.
  endif

  DbSelectArea('SE4')
  DbSetOrder(1)

  if !SE4->(MsSeek(xFilial('SE4') + '1'))
    lOk := .F.
  endif

  DbSelectArea('SA1')
  DbSetOrder(1)
  
  if !SA1->(MsSeek(xFilial('SA1') + '987654'))
    lOk := .F.
  endif

  if lOk
    //? Adicionando dados ao Array
    aAdd(aCabec,{'C5_NUM'    , '000100'      , NIL})
    aAdd(aCabec,{'C5_TIPO'   , 'N'           , NIL})
    aAdd(aCabec,{'C5_CLIENTE', SA1->A1_COD   , NIL})
    aAdd(aCabec,{'C5_LOJACLI', SA1->A1_LOJA  , NIL})
    aAdd(aCabec,{'C5_TIPINC' , '1'           , NIL})
    aAdd(aCabec,{'C5_CONDPAG', SE4->E4_CODIGO, NIL})
    
    for nI := 1 To 3
      aLinha := {}
      aAdd(aLinha,{'C6_ITEM'   , StrZero(nI,2), NIL})
      aAdd(aLinha,{'C6_PRODUTO', SB1->B1_COD  , NIL})
      aAdd(aLinha,{'C6_QTDVEN' , 10           , NIL})
      aAdd(aLinha,{'C6_PRCVEN' , 200          , NIL})
      aAdd(aLinha,{'C6_PRUNIT' , 200          , NIL})
      aAdd(aLinha,{'C6_VALOR'  , 2000         , NIL})
      aAdd(aLinha,{'C6_TES'    , '501'        , NIL})
      aAdd(aItens, aLinha)
    next
    
    //? Executa a rotina automática
    MSExecAuto({|x, y, z| MATA410(x, y, z)}, aCabec, aItens, nOper) //? nOper = 4 - Operação de Alteração
    
    //? Se houver algum erro
    if lMsErroAuto
      //? Apresenta o erro
      MostraErro()
    endif
  endif
Return
  