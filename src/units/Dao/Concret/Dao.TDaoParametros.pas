unit Dao.TDaoParametros;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Dao.TDaoBase, Dao.IDaoParametros,
  Sistema.TParametros;

type

  TDaoParametros = class(TDaoBase, IDaoParametros)
  private
    procedure ObjectToParams(ds: TFDQuery; Parametros: TParametros);
    function ParamsToObject(ds: TFDQuery): TParametros;

  public
    procedure IncluiParametros(Parametros: TParametros);
    procedure AtualizaParametros(Parametros: TParametros);
    function GetParametros(): TParametros;
  end;

implementation

{ TDaoParametros }
uses Dominio.Entidades.TFactory, Util.Exceptions;

procedure TDaoParametros.AtualizaParametros(Parametros: TParametros);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := '' + 'UPDATE parametros ' + 'SET    vendeclientebloqueado = :VENDECLIENTEBLOQUEADO, ' + '       atualizaclientenavenda = :ATUALIZACLIENTENAVENDA, ' +
        '       BLOQUEARCLIENTECOMATRASO = :BLOQUEARCLIENTECOMATRASO, ' + '       BACKUPDIARIO = :BACKUPDIARIO, ' + '       modeloimpressora = :MODELOIMPRESSORA, ' +
        '       portaimpressora = :PORTAIMPRESSORA, ' + '       velocidade = :VELOCIDADE,' + '       VERSAOBD = :VERSAOBD,' + '       IMPRIMIR2VIAS = :IMPRIMIR2VIAS, ' +
        '       IMPRIMIRITENS2VIA = :IMPRIMIRITENS2VIA,' + '       VALIDADEORCAMENTO = :VALIDADEORCAMENTO, ' + '       LOGOMARCAETIQUETA = :LOGOMARCAETIQUETA, ' +
        '       PESQUISAPRODUTOPOR = :PESQUISAPRODUTOPOR ';

      ObjectToParams(qry, Parametros);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha AtualizaParametros: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParametros.GetParametros: TParametros;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := '' + 'select *  ' + 'from  Parametros ';

      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha GetParametros: ' + E.Message);
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

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := '' + 'INSERT INTO parametros ' + '            (vendeclientebloqueado, ' + '             atualizaclientenavenda, ' + '             BLOQUEARCLIENTECOMATRASO, ' +
        '             modeloimpressora, ' + '             portaimpressora, ' + '             BACKUPDIARIO, ' + '             VERSAOBD, ' + '             IMPRIMIR2VIAS, ' +
        '             IMPRIMIRITENS2VIA, ' + '             VALIDADEORCAMENTO, ' + '             PESQUISAPRODUTOPOR, ' + '             LOGOMARCAETIQUETA, ' + '             velocidade) ' +
        'VALUES     ( :VENDECLIENTEBLOQUEADO, ' + '             :ATUALIZACLIENTENAVENDA, ' + '             :BLOQUEARCLIENTECOMATRASO, ' + '             :MODELOIMPRESSORA, ' +
        '             :PORTAIMPRESSORA, ' + '             :BACKUPDIARIO, ' + '             :VERSAOBD, ' + '             :IMPRIMIR2VIAS, ' + '             :IMPRIMIRITENS2VIA, ' +
        '             :VALIDADEORCAMENTO, ' + '             :PESQUISAPRODUTOPOR, ' + '             :LOGOMARCAETIQUETA, ' + '             :VELOCIDADE )';

      ObjectToParams(qry, Parametros);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Incluir Parametros: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

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
      ds.Params.ParamByName('IMPRIMIR2VIAS').AsBoolean := Parametros.Impressora.IMPRIMIR2VIAS;

    if ds.Params.FindParam('BACKUPDIARIO') <> nil then
      ds.Params.ParamByName('BACKUPDIARIO').AsBoolean := Parametros.BACKUPDIARIO;

    if ds.Params.FindParam('IMPRIMIRITENS2VIA') <> nil then
      ds.Params.ParamByName('IMPRIMIRITENS2VIA').AsBoolean := Parametros.Impressora.IMPRIMIRITENS2VIA;

    if ds.Params.FindParam('MODELOIMPRESSORA') <> nil then
      ds.Params.ParamByName('MODELOIMPRESSORA').AsString := Parametros.Impressora.MODELOIMPRESSORA;
    if ds.Params.FindParam('PORTAIMPRESSORA') <> nil then
      ds.Params.ParamByName('PORTAIMPRESSORA').AsString := Parametros.Impressora.PORTAIMPRESSORA;
    if ds.Params.FindParam('VELOCIDADE') <> nil then
      ds.Params.ParamByName('VELOCIDADE').AsString := Parametros.Impressora.VELOCIDADE;

    if ds.Params.FindParam('VERSAOBD') <> nil then
      ds.Params.ParamByName('VERSAOBD').AsString := Parametros.VERSAOBD;

    if ds.Params.FindParam('LOGOMARCAETIQUETA') <> nil then
    begin
      if Parametros.LOGOMARCAETIQUETA <> nil then
        ds.Params.ParamByName('LOGOMARCAETIQUETA').Assign(Parametros.LOGOMARCAETIQUETA.Picture.Graphic);
    end;

  except
    on E: Exception do
      raise TDaoException.Create('Falha ao associar parâmetros TDaoParametros: ' + E.Message);
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
    Result.Impressora.MODELOIMPRESSORA := ds.FieldByName('MODELOIMPRESSORA').AsString;
    Result.Impressora.PORTAIMPRESSORA := ds.FieldByName('PORTAIMPRESSORA').AsString;
    Result.Impressora.VELOCIDADE := ds.FieldByName('VELOCIDADE').AsString;
    Result.Impressora.IMPRIMIR2VIAS := ds.FieldByName('IMPRIMIR2VIAS').AsInteger = 1;
    Result.Impressora.IMPRIMIRITENS2VIA := ds.FieldByName('IMPRIMIRITENS2VIA').AsInteger = 1;
    Result.VERSAOBD := ds.FieldByName('VERSAOBD').AsString;

    if not ds.FieldByName('LOGOMARCAETIQUETA').IsNull then
    begin
      Result.LOGOMARCAETIQUETA := TImage.Create(nil);
      Result.LOGOMARCAETIQUETA.Picture.Graphic := TJpegimage.Create;
      Result.LOGOMARCAETIQUETA.Picture.Graphic.Assign(ds.FieldByName('LOGOMARCAETIQUETA'));
    end;

  except
    on E: Exception do
      raise TDaoException.Create('Falha no ParamsToObject TParametros: ' + E.Message);
  end;
end;

end.
