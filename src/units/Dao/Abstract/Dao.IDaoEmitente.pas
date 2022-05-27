unit Dao.IDaoEmitente;

interface

uses
  System.SysUtils, System.Classes,
  Dao.TDaoBase,
  Dominio.Entidades.TEmitente, Data.DB;

type
  IDaoEmitente = interface
    procedure IncluiEmitente(Emitente: TEmitente);
    procedure AtualizaEmitente(Emitente: TEmitente);
    function GetEmitente(): TEmitente;
    function GetEmitenteAsDataSet(): TDataSet;
  end;

implementation

end.
