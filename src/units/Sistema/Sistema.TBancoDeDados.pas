unit Sistema.TBancoDeDados;

interface

uses
  system.SysUtils, Vcl.ExtCtrls,
  Dominio.Entidades.TEntity,


  Util.TCript;

type

  TParametrosBancoDeDados = class(TEntity)
  private
    FDataBase: String;
    FSenha: String;
    FServidor: String;
    FUsuario: String;

    function GetDataBase: string;
    function GetSenha: string;
    function GetSenhaProxy: string;
    function GetServidor: string;

    function GetUsuario: string;

    procedure SetSenha(const Value: string);
    procedure SetSenhaProxy(const Value: string);
    procedure SetServidor(const Value: string);

    procedure SetUsuario(const Value: string);
    procedure SetDataBase(const Value: string);
  public
    property Servidor: string read GetServidor write SetServidor;
    property Database: string read GetDataBase write SetDataBase;
    property Usuario: string read GetUsuario write SetUsuario;
    property Senha: string read GetSenha write SetSenha;
    property SenhaProxy: string read GetSenhaProxy write SetSenhaProxy;

    constructor create(aDatabase, aUsuario, aSenha: string);
  end;

implementation

uses Sistema.Constantes;

constructor TParametrosBancoDeDados.create(aDatabase, aUsuario, aSenha: string);
begin
  inherited Create;
  self.FDataBase := aDatabase;
  self.Usuario := aUsuario;
  self.Senha := aSenha;
end;

function TParametrosBancoDeDados.GetDataBase: string;
begin
  Result := FDataBase
end;

function TParametrosBancoDeDados.GetSenha: string;
begin
  Result := FSenha
end;

function TParametrosBancoDeDados.GetSenhaProxy: string;
begin
  Result := TCript.StringDescripty(CHAVE, FSenha);
end;

procedure TParametrosBancoDeDados.SetSenhaProxy(const Value: string);
begin
  FSenha := TCript.StringEncripty(CHAVE, Value);
end;

function TParametrosBancoDeDados.GetServidor: string;
begin
  Result := FServidor
end;

function TParametrosBancoDeDados.GetUsuario: string;
begin
  Result := FUsuario
end;

procedure TParametrosBancoDeDados.SetDataBase(const Value: string);
begin
  if Value <> FDataBase then
  begin
    FDataBase := Value;
    Notify('DataBase');
  end;
end;

procedure TParametrosBancoDeDados.SetSenha(const Value: string);
begin
  if Value <> FSenha then
  begin
    FSenha := Value;
    Notify('Senha');
  end;
end;

procedure TParametrosBancoDeDados.SetServidor(const Value: string);
begin
  if Value <> FServidor then
  begin
    FServidor := Value;
    Notify('Servidor');
  end;
end;

procedure TParametrosBancoDeDados.SetUsuario(const Value: string);
begin
  if Value <> FUsuario then
  begin
    FUsuario := Value;
    Notify('Usuario');
  end;
end;

end.
