unit Dao.IDaoPontoVenda;

interface

uses
  Sistema.Parametros.PontoVenda;

type

  IDaoPontoVenda = interface
    procedure AtualizaPontoVenda(aPontoVenda: TPontoVenda);
    function GetParametros(): TPontoVenda;
  end;

implementation

end.
