unit AppSerial.DAO.TDAOClientePED;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  DAO.TDaoBase, AppSerial.DAO.IDAOClientePED, AppSerial.Dominio.TClientePED,
  System.Generics.Collections, Util.Exceptions;

type

  TDAOClientePED = class(TDaoBase, IDAOClientePED)
  private
    procedure ObjectToParams(ds: TFDQuery; Cliente: TClientePED);
    function ParamsToObject(ds: TFDQuery): TClientePED;
    function Update(Cliente: TClientePED): Integer;
    function Insert(Cliente: TClientePED): Integer;

  public
    function Listar(): TObjectList<TClientePED>;
    function Salvar(Cliente: TClientePED): Integer;
    function Delete(Cliente: TClientePED): Integer;
    function Count(): Integer;
  end;

implementation

{ TDAOClientePED }

function TDAOClientePED.Listar: TObjectList<TClientePED>;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  cliente '
        + 'order by NOME';

      qry.open;

      Result := TObjectList<TClientePED>.Create();

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Listar Cliente: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

procedure TDAOClientePED.ObjectToParams(ds: TFDQuery; Cliente: TClientePED);
begin
  EntityToParams(ds, Cliente);
end;

function TDAOClientePED.ParamsToObject(ds: TFDQuery): TClientePED;
begin
  try
    Result := TClientePED.Create();
    FieldsToEntity(ds, Result);

  except
    on E: Exception do
      raise TDaoException.Create('Falha no ParamsToObject Cliente: ' + E.Message);
  end;
end;

function TDAOClientePED.Salvar(Cliente: TClientePED): Integer;
begin
  if Cliente.CODIGO = '' then
    Insert(Cliente)
  else
    Update(Cliente);
end;

function TDAOClientePED.Update(Cliente: TClientePED): Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'UPDATE cliente '
        + 'SET    nome = :nome, '
        + '       cnpj = :cnpj, '
        + '       telefone = :telefone, '
        + '       celular = :celular, '
        + '       contato = :contato '
        + 'WHERE  codigo = :codigo';

      ObjectToParams(qry, Cliente);

      qry.ExecSQL;

      Result := qry.RowsAffected;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Inserir Cliente: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

function TDAOClientePED.Count: Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'select count(*) as total '
        + 'from  cliente ';

      qry.open;

      Result := qry.FieldByName('total').AsInteger;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Listar Cliente: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

function TDAOClientePED.Delete(Cliente: TClientePED): Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'delete from cliente '
        + ' WHERE  codigo = :codigo';

      ObjectToParams(qry, Cliente);

      qry.ExecSQL;

      Result := qry.RowsAffected;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha delete Cliente: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

function TDAOClientePED.Insert(Cliente: TClientePED): Integer;
var
  qry: TFDQuery;
  Uid: TGuid;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try

      CreateGuid(Uid);

      Cliente.CODIGO := Uid.ToString;

      qry.SQL.Text := ''
        + 'INSERT INTO cliente '
        + '            (codigo, '
        + '             nome, '
        + '             cnpj, '
        + '             telefone, '
        + '             celular, '
        + '             contato) '
        + 'VALUES      ( :codigo, '
        + '              :nome, '
        + '              :cnpj, '
        + '              :telefone, '
        + '              :celular, '
        + '              :contato)';

      ObjectToParams(qry, Cliente);

      qry.ExecSQL;

      Result := qry.RowsAffected;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Inserir Cliente: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

end.
