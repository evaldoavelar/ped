unit AppSerial.Dao.IDAOLicenca;

interface
   uses
  System.Generics.Collections, AppSerial.Dominio.TLicencaPED;

type
  IDAOLicenca = interface

    function Listar(codigoCliente : string): TObjectList<TLicencaPED>;
    function Salvar(Licenca: TLicencaPED): Integer;
    function Delete(Licenca: TLicencaPED): Integer;
    function CountAtivas: Integer;
  end;
implementation

end.
