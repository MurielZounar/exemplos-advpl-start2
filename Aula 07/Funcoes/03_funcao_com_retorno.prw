#INCLUDE 'TOTVS.CH'

  /*/{Protheus.doc} User Function RecebeNome
  (long_description)
  @type  Function
  @author Muriel Zounar
  @since 08/02/2023
  /*/
User Function RecebeNome()
  Local cNome := ''

  cNome := PreencheNome() //* a vari�vel cNome recebe o retorna da fun��o preenche nome.

  MSGINFO(cNome, 'Nome Retornado')
Return

Static Function PreencheNome()
  Local cNomeRetorno := ''

  cNomeRetorno := 'Muriel Zounar'
Return cNomeRetorno
