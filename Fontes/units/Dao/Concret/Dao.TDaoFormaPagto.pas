unit Dao.TDaoFormaPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase,Dao.IDaoFormaPagto,
  Dominio.Entidades.TFormaPagto;

type

  TDaoFormaPagto = class(TDaoBase,IDaoFormaPagto)
  private
    procedure ObjectToParams(ds: TFDQuery; FormaPagtos: TFormaPagto);
    function ParamsToObject(ds: TFDQuery): TFormaPagto;

  public
    procedure ExcluirFormaPagto(id: Integer);
    procedure IncluiPagto(FormaPagtos: TFormaPagto);
    procedure ValidaForma(FormaPagtos: TFormaPagto);
    procedure AtualizaFormaPagtos(FormaPagtos: TFormaPagto);
    function GeTFormaPagto(id: Integer): TFormaPagto;
    function GeTFormaByDescricao(DESCRICAO: string): TFormaPagto;
    function Lista(): TDataSet;
    function Listar(campo, valor: string): TDataSet;
    function ListaObject(): TObjectList<TFormaPagto>;
    function GeraID: Integer;

  end;

implementation

{ TDaoFormaPagto }

uses Dominio.Entidades.TFactory, Util.Exceptions;

procedure TDaoFormaPagto.ExcluirFormaPagto(id: Integer);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  FORMAPAGTO '
        + 'WHERE '
        + '     id = :id';

      qry.ParamByName('id').AsInteger := id;
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro n�o pode ser exclu�do porque est� amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.Message);
      end;
    end;
  finally
      FreeAndNil(qry);
  end;

end;

procedure TDaoFormaPagto.AtualizaFormaPagtos(FormaPagtos: TFormaPagto);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update FORMAPAGTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     JUROS = :JUROS, '
        + '     QUANTASVEZES = :QUANTASVEZES   '
        + 'where       '
        + '     id = :id ';

      ValidaForma(FormaPagtos);
      ObjectToParams(qry, FormaPagtos);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha AtualizaFormaPagtos: ' + E.Message);
      end;
    end;
  finally
      FreeAndNil(qry);
  end;

end;

function TDaoFormaPagto.GeraID: Integer;
begin
  Result := AutoIncremento('FORMAPAGTO', 'ID');
end;

function TDaoFormaPagto.GeTFormaByDescricao(DESCRICAO: string): TFormaPagto;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'where  '
        + '    DESCRICAO = :DESCRICAO ';

      qry.ParamByName('DESCRICAO').AsString := DESCRICAO;
      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha GeTFormaPagto: ' + E.Message);
      end;
    end;
  finally
      FreeAndNil(qry);
  end;

end;

function TDaoFormaPagto.GeTFormaPagto(id: Integer): TFormaPagto;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'where  '
        + '    id = :id ';

      qry.ParamByName('ID').AsInteger := id;
      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha GeTFormaPagto: ' + E.Message);
      end;
    end;
  finally
      FreeAndNil(qry);
  end;

end;

procedure TDaoFormaPagto.IncluiPagto(FormaPagtos: TFormaPagto);
var
  qry: TFDQuery;
begin

  if Self.GeTFormaByDescricao(FormaPagtos.DESCRICAO) <> nil then
    raise Exception.Create('Forma de pagamento j� existe');

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO FORMAPAGTO '
        + '            (id, '
        + '             DESCRICAO, '
        + '            JUROS, '
        + '             QUANTASVEZES ) '
        + 'VALUES      (:id, '
        + '             :DESCRICAO, '
        + '            :JUROS, '
        + '             :QUANTASVEZES )';

      ValidaForma(FormaPagtos);
      ObjectToParams(qry, FormaPagtos);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Pagamento Cliente: ' + E.Message);
      end;
    end;
  finally
      FreeAndNil(qry);
  end;

end;

function TDaoFormaPagto.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  FORMAPAGTO '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by QUANTASVEZES';

    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pagto: ' + E.Message);
    end;
  end;

end;

function TDaoFormaPagto.Lista: TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  FORMAPAGTO '
      + 'order by QUANTASVEZES';

    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pagto: ' + E.Message);
    end;
  end;
end;

function TDaoFormaPagto.ListaObject: TObjectList<TFormaPagto>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'order by QUANTASVEZES';

      qry.open;

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.next;
      end;

    finally
        FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pagto: ' + E.Message);
    end;
  end;

end;

procedure TDaoFormaPagto.ObjectToParams(ds: TFDQuery; FormaPagtos: TFormaPagto);
begin
  try
    EntityToParams(ds,FormaPagtos);

   // if ds.Params.FindParam('ID') <> nil then
//      ds.Params.ParamByName('ID').AsInteger := FormaPagtos.id;
//    if ds.Params.FindParam('DESCRICAO') <> nil then
//      ds.Params.ParamByName('DESCRICAO').AsString := FormaPagtos.DESCRICAO;
//    if ds.Params.FindParam('QUANTASVEZES') <> nil then
//      ds.Params.ParamByName('QUANTASVEZES').AsInteger := FormaPagtos.QUANTASVEZES;
//    if ds.Params.FindParam('JUROS') <> nil then
//      ds.Params.ParamByName('JUROS').AsCurrency := FormaPagtos.JUROS;

  except
    on E: Exception do
      raise TDaoException.Create('Falha ao associar par�metros TFormaPagto: ' + E.Message);
  end;
end;

function TDaoFormaPagto.ParamsToObject(ds: TFDQuery): TFormaPagto;
begin
  try
    Result := TFormaPagto.Create();
    FieldsToEntity(ds,Result);

   // Result.id := ds.FieldByName('ID').AsInteger;
//    Result.DESCRICAO := ds.FieldByName('DESCRICAO').AsString;
//    Result.QUANTASVEZES := ds.FieldByName('QUANTASVEZES').AsInteger;
//    Result.JUROS := ds.FieldByName('JUROS').AsCurrency;

  except
    on E: Exception do
      raise TDaoException.Create('Falha no ParamsToObject TFormaPagto: ' + E.Message);
  end;
end;

procedure TDaoFormaPagto.ValidaForma(FormaPagtos: TFormaPagto);
begin
  if FormaPagtos.DESCRICAO = '' then
    raise Exception.Create('Descri��o do Pagamento n�o informado');

  if FormaPagtos.QUANTASVEZES <= 0 then
    raise Exception.Create('Valor inv�lido para quantas vezes');

end;

end.
