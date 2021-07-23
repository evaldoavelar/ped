unit Dao.IDaoCondicaoPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase, Dominio.Entidades.CondicaoPagto;

type

  IDaoCondicaoPagto = interface
    ['{5B9CC2E0-76B4-4D47-A69A-A2EA7AE6F799}']
    procedure Excluir(id: Integer);
    procedure ExcluirPorPagamento(aIDPAGTO: Integer);
    procedure Inclui(aCondicaoPagto: TCONDICAODEPAGTO);
    procedure ValidaCondicao(aCondicaoPagto: TCONDICAODEPAGTO);
    procedure Atualiza(aCondicaoPagto: TCONDICAODEPAGTO);
    function GeTCONDICAODEPAGTO(id: Integer): TCONDICAODEPAGTO;
    function ListaObject(aIDPAGTO: Integer): tLIST<TCONDICAODEPAGTO>;
  end;

implementation

end.
