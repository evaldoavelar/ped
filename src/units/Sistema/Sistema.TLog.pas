unit Sistema.TLog;

interface

uses
  SysUtils, System.Classes, Data.DB, Utils.IO,  FireDAC.Comp.Client,
  Winapi.Windows;

type

  TTipoLog = (Custom, Info, Debug, Erro);

  TTipoLogHelp = record helper for TTipoLog
    function ToString: string;
  end;

  TLog = class
  private
    class var
      FCache: TStringList;
    class var
      FGravarCache: Boolean;
    class procedure GravarLog(aTexto: string; aTipo: TTipoLog);

  public
    class var Ativar: Boolean;
    class var ArquivoLog: string;

    class procedure Custom(aTexto: string); overload; static;
    class procedure Custom(const aTexto: string; const Args: array of const); overload; static;

    class procedure i(aTexto: string); static;
    class procedure d(aTexto: string); overload; static;
    class procedure d(aTexto: string; aConteudo: string); overload; static;
    class procedure d(const aTexto: string; const Args: array of const); overload; static;
    class procedure d(qry: TFDQuery); overload; static;
    class procedure d(ds: TFDQuery; fields: Boolean); overload;

    class procedure Start; static;
    class procedure Clean(aDiasAposCriacao: integer); static;
    class procedure IniciaCache; overload;
    class procedure FinalizaCache; overload;

  end;

implementation

function TTipoLogHelp.ToString: string;
begin
  case Self of
    Custom:
      result := 'custom';
    Info:
      result := 'info';
    Debug:
      result := 'debug';
    Erro:
      result := 'erro';
  end;
end;

class procedure TLog.d(qry: TFDQuery);
var
  i: integer;
  aux: TStringList;
begin
  try
    aux := TStringList.Create;
    aux.Add(qry.Name);
    aux.Add(qry.SQL.Text);

    for i := 0 to pred(qry.Params.Count) do
    begin
      aux.Add(qry.Params[i].Name + ' = ' + qry.Params[i].AsString);
    end;

    GravarLog(aux.Text, TTipoLog.Debug);
    aux.free;

  except
    on E: Exception do
    begin
      TLog.d('LogQuery ' + E.Message);
    end;
  end;

end;

class procedure TLog.Custom(aTexto: string);
begin
  GravarLog(aTexto, TTipoLog.Custom);
end;

class procedure TLog.Clean(aDiasAposCriacao: integer);
begin
  try
    d('Apagando logs antigos...');
    TUtilsIO.DeleteArquivosAntigos(ExtractFilePath(ArquivoLog), 'log', false, aDiasAposCriacao);
  except
  end;
end;

class procedure TLog.Custom(const aTexto: string; const Args: array of const);
begin
  GravarLog(Format(aTexto, Args), TTipoLog.Custom);
end;

class procedure TLog.d(const aTexto: string; const Args: array of const);
begin
  GravarLog(Format(aTexto, Args), TTipoLog.Debug);
end;

class procedure TLog.d(aTexto, aConteudo: string);
var
  linha: string;
begin
  linha := aTexto + ' - ' + aConteudo;
  GravarLog(linha, TTipoLog.Debug);
end;

class procedure TLog.d(aTexto: string);
begin
  GravarLog(aTexto, TTipoLog.Debug);
end;

class procedure TLog.GravarLog(aTexto: string; aTipo: TTipoLog);
var
  tft: TextFile;
  linha: string;
begin

  if not Ativar then
    Exit;

  if (ArquivoLog = '') then
    raise Exception.Create('O nome do Arquivo de Log não foi informado!');

  try
    case aTipo of
      TTipoLog.Custom:
        linha := 'C-' + FormatDateTime('dd/mm/yy hh:mm:ss - ', Now) + aTexto;
      TTipoLog.Info:
        linha := 'I-' + FormatDateTime('dd/mm/yy hh:mm:ss - ', Now) + aTexto;
      TTipoLog.Debug:
        linha := 'D-' + FormatDateTime('dd/mm/yy hh:mm:ss - ', Now) + aTexto;
    end;
    OutputDebugString(PChar(linha));

    AssignFile(tft, ArquivoLog);
    if FileExists(ArquivoLog) then
      Append(tft)
    else
      ReWrite(tft);

    Writeln(tft, linha);
    Closefile(tft);
  except
  end;

end;

class procedure TLog.i(aTexto: string);
begin
  GravarLog(aTexto, TTipoLog.Info);
end;

class procedure TLog.IniciaCache;
begin
  FCache := TStringList.Create;
  FGravarCache := true;
end;

class procedure TLog.FinalizaCache;
begin
  try
    FGravarCache := false;
    GravarLog(FCache.Text, TTipoLog.Debug);
    FCache.free;
    FCache := nil;
  except
  end;
end;

class procedure TLog.Start;
begin
  FCache := nil;
  FGravarCache := false;
end;

class procedure TLog.d(ds: TFDQuery; fields: Boolean);
var
  i: integer;
  LLinha: string;
begin
  ds.First;

  d(ds.Name);

  for i := 0 to ds.FieldCount - 1 do
    LLinha := LLinha + ds.fields[i].FieldName + #9;

  d(LLinha);

  while not ds.Eof do
  begin
    LLinha := '';
    for i := 0 to ds.FieldCount - 1 do
    begin
      LLinha := LLinha + ds.fields[i].AsString + StringOfChar(' ', Length(ds.fields[i].FieldName) - Length(ds.fields[i].AsString)) + #9;
    end;
    d(LLinha);
    ds.Next;
  end;

  ds.First;
end;

end.
