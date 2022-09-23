unit Dao.IDaoFormaPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TFormaPagto;

type

  IDaoFormaPagto = interface
    ['{5B9CC2E0-76B4-4D47-A69A-A2EA7AE6F799}']
    procedure ExcluirFormaPagto(id: Integer);
    procedure IncluiPagto(FormaPagtos: TFormaPagto);
    procedure ValidaForma(FormaPagtos: TFormaPagto);
    procedure AtualizaFormaPagtos(FormaPagtos: TFormaPagto);
    function GeTFormaPagto(id: Integer): TFormaPagto;
    function GeTFormaByDescricao(DESCRICAO: string): TFormaPagto;
    function Lista(): TDataSet;
    function Listar(aDescricao: string): TObjectList<TFormaPagto>; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function ListaObject(): TObjectList<TFormaPagto>;
    function ListaAtivosObject(): TObjectList<TFormaPagto>;
    function GeraID: Integer;
  end;

implementation

end.
