unit AppSerial.Dao.IDAOClientePED;

interface

uses
  System.Generics.Collections, AppSerial.Dominio.TClientePED;

type
  IDAOClientePED = interface
    ['{7110E6CB-C183-4624-9721-25B732CC9E12}']
    function Listar(): TObjectList<TClientePED>;
    function Salvar(Cliente: TClientePED): Integer;
    function Delete(Cliente: TClientePED): Integer;
    function Count():Integer;
  end;

implementation

end.
