unit Dao.TDaoControleCaixa;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.IDAOControleCaixa,
  Dominio.Entidades.TControleCaixa,
  Dao.TDaoBase, Sistema.TLog;

type
  TDaoControleCaixa = class(TDaoBase, IDAOControleCaixa)
  public
    function AbrirCaixa(aControle: TControleCaixa): integer;
    function FecharCaixa(aControle: TControleCaixa): integer;
    function CaixaAnterior(aNumCaixa: string): TControleCaixa;
    function CaixaAberto(aNumCaixa: string): TControleCaixa;
  private
    function ParamsToObject(ds: TFDQuery): TControleCaixa;
  public
    class function New(Connection: TFDConnection; aKeepConection: Boolean): IDAOControleCaixa;
  end;

implementation

uses
  Util.Exceptions;
{ TDAOParcelaPagamento }

function TDaoControleCaixa.AbrirCaixa(aControle: TControleCaixa): integer;
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  try
    try
      aControle.ID := AutoIncremento('CONTROLECAIXA', 'ID');
      qry.SQL.Text := ''
        + 'INSERT INTO CONTROLECAIXA (ID, DATAABERTURA, NUMCAIXA, CODVEN, VALORABERTURA ) '
        + 'VALUES (:ID, :DATAABERTURA, :NUMCAIXA, :CODVEN, :VALORABERTURA)';

      EntityToParams(qry, aControle);
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Parcela: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoControleCaixa.ParamsToObject(ds: TFDQuery): TControleCaixa;
begin
  try
    Result := TControleCaixa.Create();
    FieldsToEntity(ds, Result);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.message);
    end;
  end;

end;

function TDaoControleCaixa.CaixaAberto(aNumCaixa: string): TControleCaixa;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  CONTROLECAIXA '
        + 'WHERE '
        + ' DATAFECHAMENTO is null'
        + ' and NUMCAIXA = :NUMCAIXA';

      qry.ParamByName('NUMCAIXA').AsString := aNumCaixa;
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

        if E.message.Contains('unavailable database') then
          raise Exception.Create('Banco de dados não disponível')
        else
          raise TDaoException.Create('Falha CaixaAberto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoControleCaixa.CaixaAnterior(aNumCaixa: string): TControleCaixa;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  CONTROLECAIXA '
        + 'WHERE '
        + '    id = (select first 1 id from CONTROLECAIXA '
        + '            where NUMCAIXA = :NUMCAIXA '
        + '            order by DATAFECHAMENTO desc )';

      qry.ParamByName('NUMCAIXA').AsString := aNumCaixa;
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

        if E.message.Contains('unavailable database') then
          raise Exception.Create('Banco de dados não disponível')
        else
          raise TDaoException.Create('Falha CaixaAberto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoControleCaixa.FecharCaixa(aControle: TControleCaixa): integer;
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  try
    try

      qry.SQL.Text := ''
        + 'update CONTROLECAIXA set '
        + '  DATAFECHAMENTO = :DATAFECHAMENTO, '
        + ' VALORFECHAMENTO= :VALORFECHAMENTO '
        + 'where id=:id';

      EntityToParams(qry, aControle);
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Parcela: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

class function TDaoControleCaixa.New(Connection: TFDConnection;
  aKeepConection: Boolean): IDAOControleCaixa;
begin
  Result := TDaoControleCaixa.Create(Connection, aKeepConection);
end;

end.
