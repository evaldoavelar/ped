unit Dao.TDaoPontoVenda;

interface

uses
  Dao.IDaoPontoVenda, Sistema.Parametros.PontoVenda;

type

  TDaoPontoVenda = class(TInterfacedObject, IDaoPontoVenda)
  private

    FArquivo: AnsiString;
    FNomeConfiguracao: string;
  public
    procedure AtualizaPontoVenda(aPontoVenda: TPontoVenda);
    function GetParametros(): TPontoVenda;
  public
    constructor Create(aArquivo: AnsiString);
    destructor Destroy; override;
    class function New(aArquivo:string): IDaoPontoVenda;
  end;

implementation

uses
  System.IniFiles, System.SysUtils;

{ DaoPontoVenda }

procedure TDaoPontoVenda.AtualizaPontoVenda(aPontoVenda: TPontoVenda);
var
  IniFile: String;
  Ini: TIniFile;
begin

  IniFile := FArquivo;

  Ini := TIniFile.Create(IniFile);
  try

    try
      Ini.WriteString(FNomeConfiguracao, 'NUMCAIXA', aPontoVenda.NUMCAIXA);
      Ini.WriteBool(FNomeConfiguracao, 'FUNCIONARCOMOCLIENTE', aPontoVenda.FUNCIONARCOMOCLIENTE);

    except
      on E: Exception do
        raise Exception.Create('Falha ao gravar ini Parametros.BancoDeDados: ' + E.message);
    end;
  finally
    Ini.Free;
  end;

end;

constructor TDaoPontoVenda.Create(aArquivo: AnsiString);
begin
  FArquivo := aArquivo;
  FNomeConfiguracao := 'PontoVenda'
end;

destructor TDaoPontoVenda.Destroy;
begin

  inherited;
end;

function TDaoPontoVenda.GetParametros: TPontoVenda;
var
  IniFile: String;
  Ini: TIniFile;

begin
  IniFile := FArquivo;

  result := TPontoVenda.Create();

  if FileExists(FArquivo) = false then
    Exit;

  Ini := TIniFile.Create(IniFile);
  try

    try

      result.NUMCAIXA := Ini.ReadString(FNomeConfiguracao, 'NUMCAIXA', 'caixa-01');
      result.FUNCIONARCOMOCLIENTE := Ini.ReadBool(FNomeConfiguracao, 'FUNCIONARCOMOCLIENTE', false);
    except
      on E: Exception do
        raise Exception.Create('Falha ao carregar ini Parametros.BancoDeDados: ' + E.message);
    end;

  finally
    Ini.Free;
  end;

end;

class function TDaoPontoVenda.New(aArquivo:string): IDaoPontoVenda;
begin
  result := TDaoPontoVenda.Create(aArquivo);
end;

end.
