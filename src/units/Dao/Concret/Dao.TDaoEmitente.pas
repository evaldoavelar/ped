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

uses Factory.Dao, Util.Exceptions;

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

    // if ds.Params.FindParam('RAZAO_SOCIAL') <> nil then
    // ds.Params.ParamByName('RAZAO_SOCIAL').AsString := Emitente.RAZAO_SOCIAL;
    // if ds.Params.FindParam('FANTASIA') <> nil then
    // ds.Params.ParamByName('FANTASIA').AsString := Emitente.FANTASIA;
    // if ds.Params.FindParam('RESPONSAVEL') <> nil then
    // ds.Params.ParamByName('RESPONSAVEL').AsString := Emitente.RESPONSAVEL;
    // if ds.Params.FindParam('ENDERECO') <> nil then
    // ds.Params.ParamByName('ENDERECO').AsString := Emitente.ENDERECO;
    // if ds.Params.FindParam('COMPLEMENTO') <> nil then
    // ds.Params.ParamByName('COMPLEMENTO').AsString := Emitente.COMPLEMENTO;
    // if ds.Params.FindParam('NUM') <> nil then
    // ds.Params.ParamByName('NUM').AsString := Emitente.NUM;
    // if ds.Params.FindParam('BAIRRO') <> nil then
    // ds.Params.ParamByName('BAIRRO').AsString := Emitente.BAIRRO;
    // if ds.Params.FindParam('CIDADE') <> nil then
    // ds.Params.ParamByName('CIDADE').AsString := Emitente.CIDADE;
    // if ds.Params.FindParam('UF') <> nil then
    // ds.Params.ParamByName('UF').AsString := Emitente.UF;
    // if ds.Params.FindParam('CEP') <> nil then
    // ds.Params.ParamByName('CEP').AsString := Emitente.CEP;
    // if ds.Params.FindParam('CNPJ') <> nil then
    // ds.Params.ParamByName('CNPJ').AsString := Emitente.CNPJ;
    // if ds.Params.FindParam('IE') <> nil then
    // ds.Params.ParamByName('IE').AsString := Emitente.IE;
    // if ds.Params.FindParam('IM') <> nil then
    // ds.Params.ParamByName('IM').AsString := Emitente.IM;
    // if ds.Params.FindParam('TELEFONE') <> nil then
    // ds.Params.ParamByName('TELEFONE').AsString := Emitente.TELEFONE;
    // if ds.Params.FindParam('FAX') <> nil then
    // ds.Params.ParamByName('FAX').AsString := Emitente.FAX;
    // if ds.Params.FindParam('EMAIL') <> nil then
    // ds.Params.ParamByName('EMAIL').AsString := Emitente.EMAIL;
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

    // Result.RAZAO_SOCIAL := ds.FieldByName('RAZAO_SOCIAL').AsString;
    // Result.FANTASIA := ds.FieldByName('FANTASIA').AsString;
    // Result.RESPONSAVEL := ds.FieldByName('RESPONSAVEL').AsString;
    // Result.ENDERECO := ds.FieldByName('ENDERECO').AsString;
    // Result.COMPLEMENTO := ds.FieldByName('COMPLEMENTO').AsString;
    // Result.NUM := ds.FieldByName('NUM').AsString;
    // Result.BAIRRO := ds.FieldByName('BAIRRO').AsString;
    // Result.CIDADE := ds.FieldByName('CIDADE').AsString;
    // Result.UF := ds.FieldByName('UF').AsString;
    // Result.CEP := ds.FieldByName('CEP').AsString;
    // Result.CNPJ := ds.FieldByName('CNPJ').AsString;
    // Result.IE := ds.FieldByName('IE').AsString;
    // Result.IM := ds.FieldByName('IM').AsString;
    // Result.TELEFONE := ds.FieldByName('TELEFONE').AsString;
    // Result.FAX := ds.FieldByName('FAX').AsString;
    // Result.EMAIL := ds.FieldByName('EMAIL').AsString;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.message);
    end;
  end;
end;

end.
