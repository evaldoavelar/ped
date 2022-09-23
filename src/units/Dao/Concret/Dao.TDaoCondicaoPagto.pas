unit Dao.TDaoCondicaoPagto;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error, Sistema.TLog,
  Data.DB, FireDAC.Comp.Client, Dominio.Entidades.CondicaoPagto,
  Dao.TDaoBase,  Dao.IDaoCondicaoPagto;

type
  TDaoCondicaoPagto = class(TDaoBase, IDaoCondicaoPagto)

  public
    procedure Excluir(id: Integer);
    procedure ExcluirPorPagamento(aIDPAGTO: Integer);
    procedure Inclui(aCondicaoPagto: TCONDICAODEPAGTO);
    procedure ValidaCondicao(aCondicaoPagto: TCONDICAODEPAGTO);
    procedure Atualiza(aCondicaoPagto: TCONDICAODEPAGTO);
    function GeTCONDICAODEPAGTO(id: Integer): TCONDICAODEPAGTO;
    function ListaObject(aIDPAGTO: Integer): tLIST<TCONDICAODEPAGTO>;
  private
    function GeraID: Integer;
  public

    class function New(Connection: TFDConnection): IDaoCondicaoPagto;
  end;

implementation

uses Dominio.Entidades.TFactory, Util.Exceptions;
{ TClasseBase }

procedure TDaoCondicaoPagto.Atualiza(aCondicaoPagto: TCONDICAODEPAGTO);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update CONDICAODEPAGTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     ACRESCIMO = :ACRESCIMO, '
        + '     QUANTASVEZES = :QUANTASVEZES   '
        + 'where       '
        + '     id = :id ';

      ValidaCondicao(aCondicaoPagto);
      EntityToParams(qry, aCondicaoPagto);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Atualiza Condicao Pagtos: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoCondicaoPagto.Excluir(id: Integer);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  CONDICAODEPAGTO '
        + 'WHERE '
        + '     id = :id';

      qry.ParamByName('id').AsInteger := id;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoCondicaoPagto.ExcluirPorPagamento(aIDPAGTO: Integer);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  CONDICAODEPAGTO '
        + 'WHERE '
        + '     IDPAGTO = :IDPAGTO';

      qry.ParamByName('IDPAGTO').AsInteger := aIDPAGTO;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCondicaoPagto.GeTCONDICAODEPAGTO(id: Integer): TCONDICAODEPAGTO;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  CONDICAODEPAGTO '
        + 'where  '
        + '    id = :id ';

      qry.ParamByName('ID').AsInteger := id;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
      begin
        Result := TCONDICAODEPAGTO.Create();
        FieldsToEntity(qry, Result);
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTCONDICAODEPAGTO: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCondicaoPagto.GeraID: Integer;
begin
  Result := AutoIncremento('CONDICAODEPAGTO', 'ID');
end;

procedure TDaoCondicaoPagto.Inclui(aCondicaoPagto: TCONDICAODEPAGTO);
var
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try
    try
      aCondicaoPagto.id := GeraID;

      qry.SQL.Text := ''
        + 'INSERT INTO CONDICAODEPAGTO '
        + '            (id, '
        + '             IDPAGTO, '
        + '             DESCRICAO, '
        + '             ACRESCIMO, '
        + '             QUANTASVEZES ) '
        + 'VALUES      (:id, '
        + '             :IDPAGTO, '
        + '             :DESCRICAO, '
        + '             :ACRESCIMO, '
        + '             :QUANTASVEZES )';

      ValidaCondicao(aCondicaoPagto);
      EntityToParams(qry, aCondicaoPagto);
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Cliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCondicaoPagto.ListaObject(aIDPAGTO: Integer): tLIST<TCONDICAODEPAGTO>;
var
  qry: TFDQuery;
  condicao: TCONDICAODEPAGTO;
begin

  qry := TFactory.Query();
  Result := tLIST<TCONDICAODEPAGTO>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  CONDICAODEPAGTO '
        + 'where  '
        + '    IDPAGTO = :IDPAGTO '
        + 'order by QUANTASVEZES';

      qry.ParamByName('IDPAGTO').AsInteger := aIDPAGTO;
      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        condicao := TCONDICAODEPAGTO.Create();
        FieldsToEntity(qry, condicao);
        Result.Add(condicao);
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;
end;

class function TDaoCondicaoPagto.New(Connection: TFDConnection): IDaoCondicaoPagto;
begin
  Result := TDaoCondicaoPagto.Create(Connection);
end;

procedure TDaoCondicaoPagto.ValidaCondicao(aCondicaoPagto: TCONDICAODEPAGTO);
begin
  if aCondicaoPagto.DESCRICAO = '' then
    raise Exception.Create('Descrição do Pagamento não informado');

  if aCondicaoPagto.QUANTASVEZES <= 0 then
    raise Exception.Create('Valor inválido para quantas vezes');
end;

end.
