unit Dao.TParametrosBancoDeDados;

interface

uses
  System.IniFiles,
  Dao.IDaoParametrosBancoDeDados,
  System.SysUtils,
  Sistema.TBancoDeDados,
  System.IOUtils;

type
  TDaoParametrosBancoDeDados = class(TInterfacedObject, IDaoParametrosBancoDeDados)
  private
    FArquivo: AnsiString;
    FNomeConfiguracao: string;
  public
    function Salvar(Parametros: TParametrosBancoDeDados): IDaoParametrosBancoDeDados;
    function Carregar(): TParametrosBancoDeDados;
    function SetNomeConfiguracao(aNomeConfiguracao: string): IDaoParametrosBancoDeDados;

  public
    constructor Create(aArquivo: AnsiString);
    destructor Destroy; override;
    class function New(aArquivo: AnsiString): IDaoParametrosBancoDeDados;
  end;

implementation

uses
  pcnConversao, blcksock;

{ TClasseBase }

function TDaoParametrosBancoDeDados.Carregar(): TParametrosBancoDeDados;
var
  IniFile: String;
  Ini: TIniFile;
  Parametros: TParametrosBancoDeDados;
begin
  IniFile := FArquivo;

  Parametros := TParametrosBancoDeDados.Create('','','');
  result := Parametros;

  if FileExists(FArquivo) = false then
    Exit;

  Ini := TIniFile.Create(IniFile);
  try

    try

      Parametros.Servidor := Ini.ReadString(FNomeConfiguracao, 'Servidor', '');
      Parametros.Database := Ini.ReadString(FNomeConfiguracao, 'Database', 'PED.FDB');
      Parametros.Usuario := Ini.ReadString(FNomeConfiguracao, 'Usuario', 'sysdba');
      Parametros.Senha := Ini.ReadString(FNomeConfiguracao, 'Senha', 'masterkey');
    except
      on E: Exception do
        raise Exception.Create('Falha ao carregar ini Parametros.BancoDeDados: ' + E.message);
    end;

  finally
    Ini.Free;
  end;

end;

constructor TDaoParametrosBancoDeDados.Create(aArquivo: AnsiString);
begin
  FArquivo := aArquivo;
end;

destructor TDaoParametrosBancoDeDados.Destroy;
begin

  inherited;
end;

class function TDaoParametrosBancoDeDados.New(aArquivo: AnsiString): IDaoParametrosBancoDeDados;
begin
  result := Self.Create(aArquivo);
end;

function TDaoParametrosBancoDeDados.Salvar(Parametros: TParametrosBancoDeDados): IDaoParametrosBancoDeDados;
var
  IniFile: String;
  Ini: TIniFile;
begin
  result := Self;

  IniFile := FArquivo;

  Ini := TIniFile.Create(IniFile);
  try

    try
      Ini.WriteString(FNomeConfiguracao, 'Servidor', Parametros.Servidor);
      Ini.WriteString(FNomeConfiguracao, 'Database', Parametros.Database);
      Ini.WriteString(FNomeConfiguracao, 'Usuario', Parametros.Usuario);
      Ini.WriteString(FNomeConfiguracao, 'Senha', Parametros.Senha);

    except
      on E: Exception do
        raise Exception.Create('Falha ao gravar ini Parametros.BancoDeDados: ' + E.message);
    end;
  finally
    Ini.Free;
  end;

end;

function TDaoParametrosBancoDeDados.SetNomeConfiguracao(aNomeConfiguracao: string): IDaoParametrosBancoDeDados;
begin
  result := Self;
  FNomeConfiguracao := aNomeConfiguracao;
end;

end.
