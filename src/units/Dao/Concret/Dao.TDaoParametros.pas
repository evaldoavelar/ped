unit Dao.TDaoParametros;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoParametros,
  Sistema.TParametros, Dao.IDaoPontoVenda;

type

  TDaoParametros = class(TDaoBase, IDaoParametros)
  private
    FDaoPontoVenda: IDaoPontoVenda;
    procedure ObjectToParams(ds: TFDQuery; Parametros: TParametros);
    function ParamsToObject(ds: TFDQuery): TParametros;

  public
    procedure IncluiParametros(Parametros: TParametros);
    procedure AtualizaParametros(Parametros: TParametros);
    function GetParametros(): TParametros;
  public
    constructor Create(Connection: TFDConnection; aKeepConection: Boolean; aDaoPontoVenda: IDaoPontoVenda); virtual;
  end;

implementation

{ TDaoParametros }
uses Util.Exceptions;

procedure TDaoParametros.AtualizaParametros(Parametros: TParametros);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := '' +
        'UPDATE parametros ' +
        'SET    vendeclientebloqueado = :VENDECLIENTEBLOQUEADO, ' +
        '       atualizaclientenavenda = :ATUALIZACLIENTENAVENDA, ' +
        '       BLOQUEARCLIENTECOMATRASO = :BLOQUEARCLIENTECOMATRASO, ' +
        '       BACKUPDIARIO = :BACKUPDIARIO, ' +
        '       modeloimpressora = :MODELOIMPRESSORA, ' +
        '       portaimpressora = :PORTAIMPRESSORA, ' +
        '       velocidade = :VELOCIDADE,' +
        '       VERSAOBD = :VERSAOBD,' +
        '       IMPRIMIR2VIAS = :IMPRIMIR2VIAS, ' +
        '       IMPRIMIRITENS2VIA = :IMPRIMIRITENS2VIA,' +
        '       VALIDADEORCAMENTO = :VALIDADEORCAMENTO, ' +
        '       LOGOMARCAETIQUETA = :LOGOMARCAETIQUETA, ' +
        '       SERVIDORDATABASE = :SERVIDORDATABASE, ' +
        '       SERVIDORUSUARIO = :SERVIDORUSUARIO, ' +
        '       SERVIDORSENHA = :SERVIDORSENHA, ' +
      // '       FUNCIONARCOMOCLIENTE = :FUNCIONARCOMOCLIENTE, ' +
      // '       NUMCAIXA = :NUMCAIXA, ' +
        '       DATAALTERACAO = :DATAALTERACAO, ' +
        '       PESQUISAPRODUTOPOR = :PESQUISAPRODUTOPOR ';

      ObjectToParams(qry, Parametros);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParametros: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
  FDaoPontoVenda.AtualizaPontoVenda(Parametros.PontoVenda);
end;

constructor TDaoParametros.Create(Connection: TFDConnection;
  aKeepConection: Boolean; aDaoPontoVenda: IDaoPontoVenda);
begin
  inherited Create(Connection, aKeepConection);

  FDaoPontoVenda := aDaoPontoVenda;
end;

function TDaoParametros.GetParametros: TParametros;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parametros ';

      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

      Result.PontoVenda := FDaoPontoVenda.GetParametros();
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetParametros: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParametros.IncluiParametros(Parametros: TParametros);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := '' +
        'INSERT INTO parametros ' +
        '            (vendeclientebloqueado, ' +
        '             atualizaclientenavenda, ' +
        '             BLOQUEARCLIENTECOMATRASO, ' +
        '             modeloimpressora, ' +
        '             portaimpressora, ' +
        '             BACKUPDIARIO, ' +
        '             VERSAOBD, ' +
        '             IMPRIMIR2VIAS, ' +
        '             IMPRIMIRITENS2VIA, ' +
        '             VALIDADEORCAMENTO, ' +
        '             PESQUISAPRODUTOPOR, ' +
        '             LOGOMARCAETIQUETA, ' +
      // '             FUNCIONARCOMOCLIENTE, ' +
        '             SERVIDORUSUARIO, ' +
        '             SERVIDORDATABASE, ' +
        '             SERVIDORSENHA, ' +
      // '             NUMCAIXA, ' +
        '             DATAALTERACAO, ' +
        '             velocidade) ' +
        'VALUES     ( :VENDECLIENTEBLOQUEADO, ' +
        '             :ATUALIZACLIENTENAVENDA, ' +
        '             :BLOQUEARCLIENTECOMATRASO, ' +
        '             :MODELOIMPRESSORA, ' +
        '             :PORTAIMPRESSORA, ' +
        '             :BACKUPDIARIO, ' +
        '             :VERSAOBD, ' +
        '             :IMPRIMIR2VIAS, ' +
        '             :IMPRIMIRITENS2VIA, ' +
        '             :VALIDADEORCAMENTO, ' +
        '             :PESQUISAPRODUTOPOR, ' +
        '             :LOGOMARCAETIQUETA, ' +
      // '             :FUNCIONARCOMOCLIENTE, ' +
        '             :SERVIDORUSUARIO, ' +
        '             :SERVIDORDATABASE, ' +
        '             :SERVIDORSENHA, ' +
      // '             :NUMCAIXA, ' +
        '             :DATAALTERACAO, ' +
        '             :VELOCIDADE )';

      ObjectToParams(qry, Parametros);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Incluir Parametros: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
  FDaoPontoVenda.AtualizaPontoVenda(Parametros.PontoVenda);
end;

procedure TDaoParametros.ObjectToParams(ds: TFDQuery; Parametros: TParametros);
begin
  try

    if ds.Params.FindParam('VENDECLIENTEBLOQUEADO') <> nil then
      ds.Params.ParamByName('VENDECLIENTEBLOQUEADO').AsBoolean := Parametros.VENDECLIENTEBLOQUEADO;

    if ds.Params.FindParam('ATUALIZACLIENTENAVENDA') <> nil then
      ds.Params.ParamByName('ATUALIZACLIENTENAVENDA').AsBoolean := Parametros.ATUALIZACLIENTENAVENDA;

    if ds.Params.FindParam('BLOQUEARCLIENTECOMATRASO') <> nil then
      ds.Params.ParamByName('BLOQUEARCLIENTECOMATRASO').AsBoolean := Parametros.BLOQUEARCLIENTECOMATRASO;

    if ds.Params.FindParam('VALIDADEORCAMENTO') <> nil then
      ds.Params.ParamByName('VALIDADEORCAMENTO').AsInteger := Parametros.VALIDADEORCAMENTO;

    if ds.Params.FindParam('PESQUISAPRODUTOPOR') <> nil then
      ds.Params.ParamByName('PESQUISAPRODUTOPOR').AsInteger := Parametros.PESQUISAPRODUTOPOR;

    if ds.Params.FindParam('IMPRIMIR2VIAS') <> nil then
      ds.Params.ParamByName('IMPRIMIR2VIAS').AsBoolean := Parametros.ImpressoraTermica.IMPRIMIR2VIAS;

    if ds.Params.FindParam('BACKUPDIARIO') <> nil then
      ds.Params.ParamByName('BACKUPDIARIO').AsBoolean := Parametros.BACKUPDIARIO;

    if ds.Params.FindParam('IMPRIMIRITENS2VIA') <> nil then
      ds.Params.ParamByName('IMPRIMIRITENS2VIA').AsBoolean := Parametros.ImpressoraTermica.IMPRIMIRITENS2VIA;

    if ds.Params.FindParam('MODELOIMPRESSORA') <> nil then
      ds.Params.ParamByName('MODELOIMPRESSORA').AsString := Parametros.ImpressoraTermica.MODELOIMPRESSORA;
    if ds.Params.FindParam('PORTAIMPRESSORA') <> nil then
      ds.Params.ParamByName('PORTAIMPRESSORA').AsString := Parametros.ImpressoraTermica.PORTAIMPRESSORA;
    if ds.Params.FindParam('VELOCIDADE') <> nil then
      ds.Params.ParamByName('VELOCIDADE').AsString := Parametros.ImpressoraTermica.VELOCIDADE;

    if ds.Params.FindParam('VERSAOBD') <> nil then
      ds.Params.ParamByName('VERSAOBD').AsString := Parametros.VERSAOBD;

    if ds.Params.FindParam('SERVIDORDATABASE') <> nil then
      ds.Params.ParamByName('SERVIDORDATABASE').AsString := Parametros.SERVIDORDATABASE;
    if ds.Params.FindParam('SERVIDORUSUARIO') <> nil then
      ds.Params.ParamByName('SERVIDORUSUARIO').AsString := Parametros.SERVIDORUSUARIO;
    if ds.Params.FindParam('SERVIDORSENHA') <> nil then
      ds.Params.ParamByName('SERVIDORSENHA').AsString := Parametros.SERVIDORSENHA;
    // if ds.Params.FindParam('FUNCIONARCOMOCLIENTE') <> nil then
    // ds.Params.ParamByName('FUNCIONARCOMOCLIENTE').AsBoolean := Parametros.FUNCIONARCOMOCLIENTE;

    if ds.Params.FindParam('LOGOMARCAETIQUETA') <> nil then
    begin
      if Parametros.LOGOMARCAETIQUETA <> nil then
        ds.Params.ParamByName('LOGOMARCAETIQUETA').Assign(Parametros.LOGOMARCAETIQUETA.Picture.Graphic);
    end;

    // ds.ParamByName('NUMCAIXA').AsString := Parametros.NUMCAIXA;

    if ds.Params.FindParam('DATAALTERACAO') <> nil then
      ds.Params.ParamByName('DATAALTERACAO').AsDate := Parametros.DATAALTERACAO;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TDaoParametros: ' + E.message);
    end;
  end;
end;

function TDaoParametros.ParamsToObject(ds: TFDQuery): TParametros;
begin
  try
    Result := TParametros.Create();

    Result.VENDECLIENTEBLOQUEADO := ds.FieldByName('VENDECLIENTEBLOQUEADO').AsInteger = 1;
    Result.BLOQUEARCLIENTECOMATRASO := ds.FieldByName('BLOQUEARCLIENTECOMATRASO').AsInteger = 1;
    Result.ATUALIZACLIENTENAVENDA := ds.FieldByName('ATUALIZACLIENTENAVENDA').AsInteger = 1;
    Result.VALIDADEORCAMENTO := ds.FieldByName('VALIDADEORCAMENTO').AsInteger;
    Result.PESQUISAPRODUTOPOR := ds.FieldByName('PESQUISAPRODUTOPOR').AsInteger;
    Result.BACKUPDIARIO := ds.FieldByName('BACKUPDIARIO').AsInteger = 1;
    Result.ImpressoraTermica.MODELOIMPRESSORA := ds.FieldByName('MODELOIMPRESSORA').AsString;
    Result.ImpressoraTermica.PORTAIMPRESSORA := ds.FieldByName('PORTAIMPRESSORA').AsString;
    Result.ImpressoraTermica.VELOCIDADE := ds.FieldByName('VELOCIDADE').AsString;
    Result.ImpressoraTermica.IMPRIMIR2VIAS := ds.FieldByName('IMPRIMIR2VIAS').AsInteger = 1;
    Result.ImpressoraTermica.IMPRIMIRITENS2VIA := ds.FieldByName('IMPRIMIRITENS2VIA').AsInteger = 1;
    Result.VERSAOBD := ds.FieldByName('VERSAOBD').AsString;
    // Result.FUNCIONARCOMOCLIENTE := ds.FieldByName('FUNCIONARCOMOCLIENTE').AsInteger = 1;
    Result.SERVIDORUSUARIO := ds.FieldByName('SERVIDORUSUARIO').AsString;
    Result.SERVIDORDATABASE := ds.FieldByName('SERVIDORDATABASE').AsString;
    Result.SERVIDORSENHA := ds.FieldByName('SERVIDORSENHA').AsString;
    // Result.NUMCAIXA := ds.FieldByName('NUMCAIXA').AsString;

    if not ds.FieldByName('LOGOMARCAETIQUETA').IsNull then
    begin
      Result.LOGOMARCAETIQUETA := TImage.Create(nil);
      Result.LOGOMARCAETIQUETA.Picture.Graphic := TJpegimage.Create;
      Result.LOGOMARCAETIQUETA.Picture.Graphic.Assign(ds.FieldByName('LOGOMARCAETIQUETA'));
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TParametros: ' + E.message);
    end;
  end;
end;

end.
