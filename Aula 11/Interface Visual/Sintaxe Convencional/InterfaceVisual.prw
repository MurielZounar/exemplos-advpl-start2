#INCLUDE 'TOTVS.CH'

User Function IntVisual()
  Local cCNPJ  := Space(20)
  Local cTitle := 'Essa é uma janela bacana!'
  Local cTexto := 'CNPJ:'
  Local oDlg   := NIL
  Local nOpcao := 0

  DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 080, 300 PIXEL
  @ 014, 010 SAY cTexto SIZE 55, 07 OF oDlg PIXEL
  @ 011, 030 MSGET cCNPJ SIZE 55, 11 OF oDlg PIXEL PICTURE '@E 99.999.999/9999-99'
  DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:End()) ENABLE OF oDlg
  DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:End()) ENABLE OF oDlg
  
  ACTIVATE MSDIALOG oDlg CENTERED

  if nOpcao == 1
    FwAlertSuccess('CNPJ: ' + cCNPJ, 'TOP')
  else
    FwAlertError('Cancelado pelo usuário!', 'Cancelado!')
  endif
Return
