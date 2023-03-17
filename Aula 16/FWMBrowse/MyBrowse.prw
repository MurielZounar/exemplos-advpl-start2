#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MyBrowse
  Exemplo de uso da função FWMBrowse
  @type  Function
  @author Muriel Zounar
  @since 09/03/2023
  /*/
User Function MyBrowse() //!Mudar para MyMVC
  Local oBrowse := NIL
  
  //! Parte 1
  //? Criação de um objeto Browse / Instanciamento da Casse:
  oBrowse := FwMBrowse():New()

  //? Definição de qual tabela será exibida no Browse:
  oBrowse:SetAlias('SA1')

  //? Definição do título que será exibido no Browse:
  oBrowse:SetDescription('Meu Cad. de Clientes')

  //! Parte 2
  //? Definindo legendas do Browse:
  oBrowse:AddLegend('A1_TIPO == "F"', 'BLACK', 'Cons. Final')
  oBrowse:AddLegend('A1_TIPO == "L"', 'BROWN', 'Produtor Rural')
  oBrowse:AddLegend('A1_TIPO == "S"', 'ORANGE', 'Solidário')

  //! Parte 3
  //? Definindo filtro:
  oBrowse:SetFilterDefault('A1_TIPO=="F"') //* Obs: O filtro da aplicação não poderá ser desabilitado pelo usuário.

  //! Parte 4
  //? Desabilitar Detalhes do Browse:
  oBrowse:DisableDetails()

  //? Ativado o Browse:
  oBrowse:Activate() //*Em todas as Partes
Return
