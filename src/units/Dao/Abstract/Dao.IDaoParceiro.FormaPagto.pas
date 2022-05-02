unit Dao.IDaoParceiro.FormaPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase,
  Dominio.Entidades.TParceiro.FormaPagto;

type

  IDaoParceiroFormaPagto = interface
    ['{006C8BF1-BA89-474F-B1CA-C303AAAA3F2A}']
    procedure ExcluirParceiroFormaPagto(id: Integer);
    procedure IncluiPagto(ParceiroFormaPagtos: TParceiroFormaPagto);
    procedure ValidaForma(ParceiroFormaPagtos: TParceiroFormaPagto);
    procedure AtualizaParceiroFormaPagtos(ParceiroFormaPagtos: TParceiroFormaPagto);
    function GeTParceiroFormaPagto(id: Integer): TParceiroFormaPagto;
    function GeTFormaByDescricao(DESCRICAO: string): TParceiroFormaPagto;
    function Lista(): TDataSet;
    function Listar(campo, valor: string): TDataSet;
    function ListaObject(): TObjectList<TParceiroFormaPagto>;
    function GeraID: Integer;
  end;

implementation

end.
