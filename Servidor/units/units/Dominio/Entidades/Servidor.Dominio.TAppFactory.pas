unit Servidor.Dominio.TAppFactory;

interface

uses
System.IOUtils,
  AppSerial.Dao.IDAOClientePED, AppSerial.Dao.TDAOClientePED, AppSerial.Dominio.TLicencaPED, AppSerial.Dao.IDAOLicenca,
  AppSerial.Dao.TDAOLicencaPED, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.DApt, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, Util.Funcoes;

type

  TServerFactory = class
  class var
    FConnection: TFDConnection;
  private
    class function GetDataBase: string; static;
  public
    class function DAOClientePED: IDAOClientePED;
    class function DAOLicencaPED: IDAOLicenca;
    class function Conexao(nova: boolean = false): TFDConnection;
  end;

implementation


{ TAppFactory }

class function TServerFactory.GetDataBase: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  result := TPath.Combine(TPath.GetDocumentsPath, 'serial.db3');
{$ELSE}
  result := TUtil.DiretorioApp + '..\..\database\serial.db3';
{$ENDIF}
end;

class function TServerFactory.Conexao(nova: boolean = false): TFDConnection;
begin
  if (FConnection = nil) or nova then
  begin
    FConnection := TFDConnection.Create(nil);
    FConnection.DriverName := 'SQLite';
    FConnection.Params.UserName := '';
    FConnection.Params.Password := '';
    FConnection.Params.Database := GetDataBase;
    // FConnection.Params.Add( 'CharacterSet=ISO8859_1');
    FConnection.FetchOptions.Mode := fmAll;
    FConnection.ResourceOptions.AutoConnect := true;
    FConnection.Open();
  end;

  result := FConnection;

end;

class function TServerFactory.DAOClientePED: IDAOClientePED;
begin
  result := TDAOClientePED.Create(Conexao);
end;

class function TServerFactory.DAOLicencaPED: IDAOLicenca;
begin
  result := TDAOLicencaPED.Create(Conexao);
end;

end.
