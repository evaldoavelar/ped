unit AppSerial.DAO.TDAOLicencaPED;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  DAO.TDaoBase, AppSerial.Dominio.TLicencaPED,
  System.Generics.Collections, Util.Exceptions, AppSerial.DAO.IDAOLicenca;

type

  TDAOLicencaPED = class(TDaoBase, IDAOLicenca)
    procedure ObjectToParams(ds: TFDQuery; Licenca: TLicencaPED);
    function ParamsToObject(ds: TFDQuery): TLicencaPED;

  public
    function Listar(codigoCliente: string): TObjectList<TLicencaPED>;
    function Select(codigoCliente: string; DataInicio: TDate; Vencimento: TDate): TLicencaPED;
    function Salvar(Licenca: TLicencaPED): Integer;
    function Delete(Licenca: TLicencaPED): Integer;
    function CountAtivas: Integer;
  end;

implementation

{ TDAOLicencaPED }

function TDAOLicencaPED.CountAtivas: Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'select count(*) as total '
        + 'from  licencas '
        + ' where vencimento > :data ';

      qry.ParamByName('data').AsDate := Now;
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

function TDAOLicencaPED.Delete(Licenca: TLicencaPED): Integer;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'delete from licencas '
        + ' WHERE  codigo = :codigo';

      ObjectToParams(qry, Licenca);

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

function TDAOLicencaPED.Listar(codigoCliente: string): TObjectList<TLicencaPED>;
var
  qry: TFDQuery;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  licencas '
        + 'where CODIGOCLIENTE = :CODIGOCLIENTE '
        + 'order by vencimento desc';

      qry.ParamByName('CODIGOCLIENTE').AsString := codigoCliente;
      qry.open;

      Result := TObjectList<TLicencaPED>.Create();

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Listar Licenca: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

procedure TDAOLicencaPED.ObjectToParams(ds: TFDQuery; Licenca: TLicencaPED);
begin
  EntityToParams(ds, Licenca);
end;

function TDAOLicencaPED.ParamsToObject(ds: TFDQuery): TLicencaPED;
begin
  try
    Result := TLicencaPED.Create();
    FieldsToEntity(ds, Result);

  except
    on E: Exception do
      raise TDaoException.Create('Falha no ParamsToObject Licenca: ' + E.Message);
  end;
end;

function TDAOLicencaPED.Salvar(Licenca: TLicencaPED): Integer;
var
  qry: TFDQuery;
  Uid: TGuid;
begin

  qry := TFDQuery.Create(nil);
  qry.Connection := FConnection;
  try
    try

      CreateGuid(Uid);

      Licenca.CODIGO := Uid.ToString;

      qry.SQL.Text := ''
        + 'INSERT INTO licencas '
        + '            (codigo, '
        + '             codigocliente, '
        + '             datainicio, '
        + '             vencimento, '
        + '             serial, '
        + '             datageracao) '
        + 'VALUES     ( :codigo, '
        + '             :codigocliente, '
        + '             :datainicio, '
        + '             :vencimento, '
        + '             :serial, '
        + '             :datageracao)';

      ObjectToParams(qry, Licenca);

      qry.ExecSQL;

      Result := qry.RowsAffected;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Inserir Licenca: ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;

end;

function TDAOLicencaPED.Select(codigoCliente: string; DataInicio, Vencimento: TDate): TLicencaPED;
begin

end;

end.
