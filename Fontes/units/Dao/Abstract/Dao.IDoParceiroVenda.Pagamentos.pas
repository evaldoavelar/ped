unit Dao.IDoParceiroVenda.Pagamentos;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase,
  Dominio.Entidades.TParceiroVenda.Pagamentos;

type

  IDaoParceiroVendaPagto = interface
    ['{0DF5CEF8-CA06-4C87-9A68-71290B9977BF}']
    procedure ExcluirParceiroVendaPagto(id: Integer);
    procedure IncluiPagto(ParceiroVendaPagtos: TParceiroVendaPagto);
    procedure ValidaParceiroVenda(ParceiroVendaPagto: TParceiroVendaPagto);
    procedure AtualizaParceiroVendaPagtos(ParceiroVendaPagtos: TParceiroVendaPagto);
    function GeTParceiroVendaPagto(seq, idParceiroVenda: Integer): TParceiroVendaPagto;
    function Lista(idParceiroVenda: Integer): TDataSet;
    function ListaObject(idParceiroVenda: Integer): TObjectList<TParceiroVendaPagto>;
    function TotalizadorPorParceiro(codParceiro: string; DataInicio, DataFim: TDate): TDataSet;
  end;

implementation

end.
