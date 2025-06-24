unit Dao.TImportacao;

interface

uses
  Dao.IDaoImportacao, Dominio.Entidades.TImportacao, Dao.TDaoBase;

type

  TDaoImportacao = class(TDaoBase, IDaoImportacao)
  public
    procedure AtualizaDataImportacao(aImportacao: TImportacao);
    procedure IncluirImportacao(aImportacao: TImportacao);
    function GetUltimaImportacao(aTabela: string): TDateTime;
    function Select(aTabela: string): TImportacao;
  public

    destructor Destroy; override;

  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, Sistema.TLog, Util.Exceptions;

{ DaoImportacao }

procedure TDaoImportacao.AtualizaDataImportacao(aImportacao: TImportacao);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'update Importacao '
      + '     set '
      + '     DATAIMPORTACAO = :DATAIMPORTACAO '
      + 'where  '
      + '     TABELA = :TABELA '
      ;
    EntityToParams(qry, aImportacao);
    TLog.d(qry);
    qry.ExecSQL;

    if qry.RowsAffected = 0 then
      IncluirImportacao(aImportacao);

  finally
    FreeAndNil(qry);
  end;

end;

destructor TDaoImportacao.Destroy;
begin

  inherited;
end;

function TDaoImportacao.GetUltimaImportacao(aTabela: string): TDateTime;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT TABELA, '
      + '     DATAIMPORTACAO   '
      + ' from  IMPORTACAO  '
      + 'where  '
      + '     TABELA = :TABELA ';

    qry.ParamByName('TABELA').AsString := aTabela;

    TLog.d(qry);
    qry.Open;

    Result := qry.FieldByName('DATAIMPORTACAO').AsDateTime;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create(E.message);
    end;
  end;

end;

procedure TDaoImportacao.IncluirImportacao(aImportacao: TImportacao);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO Importacao '
      + '            (TABELA, '
      + '             DATAIMPORTACAO ) '
      + 'VALUES      ( :TABELA, '
      + '              :DATAIMPORTACAO)';

    EntityToParams(qry, aImportacao);
    TLog.d(qry);
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoImportacao.Select(aTabela: string): TImportacao;
var
  qry: TFDQuery;
begin
  Result := nil;
  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT * '
      + ' from  IMPORTACAO  '
      + 'where  '
      + '     TABELA = :TABELA ';

    qry.ParamByName('TABELA').AsString := aTabela;

    TLog.d(qry);
    qry.Open;

    if qry.IsEmpty = false then
    begin
      Result := TImportacao.Create;
      FieldsToEntity(qry, Result);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create(E.message);
    end;
  end;

end;

end.
