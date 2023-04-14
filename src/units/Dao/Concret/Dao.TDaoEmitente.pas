unit Dao.TDaoEmitente;

interface

uses
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TEmitente, Dao.IDaoEmitente;

type

  TDaoEmitente = class(TDaoBase, IDaoEmitente)
  private
    procedure ObjectToParams(ds: TFDQuery; Emitente: TEmitente);
    function ParamsToObject(ds: TFDQuery): TEmitente;

  public
    procedure IncluiEmitente(Emitente: TEmitente);
    procedure AtualizaEmitente(Emitente: TEmitente);
    function GetEmitente(): TEmitente;
    function GetEmitenteAsDataSet(): TDataSet;
  end;

implementation

{ TDaoEmitente }

uses Util.Exceptions;

procedure TDaoEmitente.AtualizaEmitente(Emitente: TEmitente);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'UPDATE emitente '
        + 'SET    razao_social = :RAZAO_SOCIAL, '
        + '       fantasia = :FANTASIA, '
        + '       responsavel = :RESPONSAVEL, '
        + '       endereco = :ENDERECO, '
        + '       complemento = :COMPLEMENTO, '
        + '       num = :NUM, '
        + '       bairro = :BAIRRO, '
        + '       cidade = :CIDADE, '
        + '       uf = :UF, '
        + '       cep = :CEP, '
        + '       cnpj = :CNPJ, '
        + '       ie = :IE, '
        + '       im = :IM, '
        + '       telefone = :TELEFONE, '
        + '       fax = :FAX, '
        + '       DATAALTERACAO = :DATAALTERACAO, '
        + '       email = :EMAIL';

      ObjectToParams(qry, Emitente);

      TLog.d(qry);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaEmitente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoEmitente.GetEmitente: TEmitente;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Emitente ';

      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetEmitente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoEmitente.GetEmitenteAsDataSet: TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  Emitente ';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetEmitente: ' + E.message);
    end;
  end;
end;

procedure TDaoEmitente.IncluiEmitente(Emitente: TEmitente);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO emitente '
        + '            (razao_social, '
        + '             fantasia, '
        + '             responsavel, '
        + '             endereco, '
        + '             complemento, '
        + '             num, '
        + '             bairro, '
        + '             cidade, '
        + '             uf, '
        + '             cep, '
        + '             cnpj, '
        + '             ie, '
        + '             im, '
        + '             telefone, '
        + '             fax, '
        + '             DATAALTERACAO, '
        + '             email) '
        + 'VALUES      ( :RAZAO_SOCIAL, '
        + '              :FANTASIA, '
        + '              :RESPONSAVEL, '
        + '              :ENDERECO, '
        + '              :COMPLEMENTO, '
        + '              :NUM, '
        + '              :BAIRRO, '
        + '              :CIDADE, '
        + '              :UF, '
        + '              :CEP, '
        + '              :CNPJ, '
        + '              :IE, '
        + '              :IM, '
        + '              :TELEFONE, '
        + '              :FAX, '
        + '              :DATAALTERACAO, '
        + '              :EMAIL )';

      ObjectToParams(qry, Emitente);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Incluir Emitente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoEmitente.ObjectToParams(ds: TFDQuery; Emitente: TEmitente);
begin
  try
    EntityToParams(ds, Emitente);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TDaoVendedor: ' + E.message);
    end;
  end;
end;

function TDaoEmitente.ParamsToObject(ds: TFDQuery): TEmitente;
begin
  try
    Result := TEmitente.Create();
    FieldsToEntity(ds, Result);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.message);
    end;
  end;
end;

end.
