#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ExemploStaticFunctions
  Função para apresentar as Static Functions aos Starters
  @type  Function
  @author Muriel Zounar
  @since 08/02/2023
  /*/
User Function ExemploStaticFunctions()
  Local cNome := 'Muriel'

  ExibeNome(cNome)
Return

Static Function ExibeNome(cNome)
  MSGINFO(cNome, 'Nome')
Return
