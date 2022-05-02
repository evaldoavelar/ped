unit Dao.IDaoParametros;

interface

uses
  System.SysUtils, System.Classes,
  Data.DB,
  Dao.TDaoBase,
  Sistema.TParametros;

type

  IDaoParametros = interface
    //asinar a interface para uso de queryinterface
    ['{74C5258F-0698-4010-A739-0438144A47F6}']
    procedure IncluiParametros(Parametros: TParametros);
    procedure AtualizaParametros(Parametros: TParametros);
    function GetParametros(): TParametros;
  end;

implementation

end.
