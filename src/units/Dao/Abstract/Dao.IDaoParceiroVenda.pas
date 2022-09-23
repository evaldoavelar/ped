unit Dao.IDaoParceiroVenda;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TParceiro.FormaPagto, Dominio.Entidades.TParceiroVenda;

type

  IDaoParceiroVenda = interface
    ['{D2D4AB1B-253E-41A5-93F6-2EF1814D8111}']
    procedure ExcluirParceiroVenda(id: Integer);
    procedure IncluiPagto(ParceiroVendas: TParceiroVenda);
    procedure AtualizaParceiroVendas(ParceiroVendas: TParceiroVenda);
    function GeTParceiroVenda(id: Integer): TParceiroVenda;
    function Lista(): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
    function ListaObject(): TObjectList<TParceiroVenda>;
    function GeraID: Integer;

  end;

implementation

end.
