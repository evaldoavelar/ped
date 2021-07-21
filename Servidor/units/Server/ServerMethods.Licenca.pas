unit ServerMethods.Licenca;

interface

uses System.SysUtils, System.JSON, REST.JSON, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.Generics.Collections, AppSerial.Dominio.TClientePED, AppSerial.Dao.IDAOClientePED, Servidor.Dominio.TAppFactory;

type
{$METHODINFO ON}
  TServerLicenca = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Clientes: TJSONObject;
    function UpdateClientes(obj: TJSONObject): string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

function TServerLicenca.Clientes: TJSONObject;
var
  Dao: IDAOClientePED;
  Clientes: TList<TClientePED>;
begin
  Dao := TServerFactory.DAOClientePED();
  Clientes := Dao.Listar();

  result := TJSON.ObjectToJsonObject(Clientes);
end;

function TServerLicenca.EchoString(Value: string): string;
begin
  result := Value;
end;

function TServerLicenca.ReverseString(Value: string): string;
begin
  result := System.StrUtils.ReverseString(Value);
end;

function TServerLicenca.UpdateClientes(obj: TJSONObject): string;
var
  cliente: TClientePED;
  Dao: IDAOClientePED;
begin
  cliente := TJSON.JsonToObject<TClientePED>(obj);

  Dao := TServerFactory.DAOClientePED();
 // Dao.Salvar(cliente);
end;

end.
